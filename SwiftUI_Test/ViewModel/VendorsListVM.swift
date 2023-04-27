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
                    self.vendors.append(VendorCardViewItem(id: $0.id,
                                                           favorited: $0.favorited,
                                                           companyName: $0.companyName,
                                                           areaServed: $0.areaServed,
                                                           shopType: $0.shopType,
                                                           businessType: $0.businessType,
                                                           coverURLString: $0.ImageAsset.mediaURL,
                                                           categories: $0.categories.map {
                        CategoryViewItem(id: $0.id,
                                         name: $0.name,
                                         iconURLString: $0.image.mediaURL)
                    },
                                                           tags: $0.tags.map { $0.name }))
                }
            }
            .store(in: &cancellables)
    }
    
    func jsonURL() -> URL {
        Bundle.main.url(forResource: "vendors", withExtension: "json")!
    }
}
