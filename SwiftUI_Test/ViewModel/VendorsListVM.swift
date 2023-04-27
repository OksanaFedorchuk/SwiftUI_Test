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
    @Published var searchText = ""
    private let parsingService = JSONParsingService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        subscribeVendors()
    }
}

private extension VendorsListVM {
    func subscribeVendors() {
        parsingService.dataTaskPublisher(for: jsonURL())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }) { [unowned self] (users: Vendors) in
                users.vendors.forEach {
                    self.vendors.append(mapVendorCardViewItem(with: $0))
                }
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
