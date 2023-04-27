//
//  VendorsListVM.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 24.04.2023.
//

import Foundation
import Combine

final class VendorsListVM: ObservableObject {
    @Published var vendors = [VendorCardViewItem]()
    @Published var searchText = String()
    private let parsingService = JSONParsingService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        subscribeData()
    }
}

// MARK: - SubscribeData
private extension VendorsListVM {
    func subscribeData() {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [unowned self] text in
                if text.count >= 3 {
                    getVendors {
                        let filtered = self.vendors.filter { item in
                            item.companyName.localizedCaseInsensitiveContains(text)
                        }
                        self.vendors = filtered
                    }
                } else {
                    getVendors()
                }
            }
            .store(in: &cancellables)
        
    }
}

// MARK:  - GetVendors
private extension VendorsListVM {
    func getVendors(_ completion: @escaping ()->() = {} ) {
        parsingService.dataTaskPublisher(for: jsonURL())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }) { [unowned self] (users: Vendors) in
                self.vendors = []
                users.vendors.forEach {
                    self.vendors.append(mapVendorCardViewItem(with: $0))
                }
                completion()
            }
            .store(in: &cancellables)
    }
    
    func mapVendorCardViewItem(with vendor: Vendor) -> VendorCardViewItem {
        VendorCardViewItem(id: vendor.id,
                           favorited: vendor.favorited,
                           companyName: vendor.companyName,
                           areaServed: vendor.areaServed,
                           shopType: vendor.shopType,
                           businessType: vendor.businessType,
                           coverURLString: vendor.ImageAsset.mediaURL,
                           categories: vendor.categories.map { CategoryViewItem(id: $0.id,
                                                                                name: $0.name,
                                                                                iconURLString: $0.image.mediaURL) },
                           tags: vendor.tags.map { $0.name })
    }
    
    func jsonURL() -> URL {
        Bundle.main.url(forResource: "vendors", withExtension: "json")!
    }
}
