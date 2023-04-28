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
    @Published var errorWrapper: ErrorWrapper?
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
                        if self.vendors.isEmpty {
                            self.errorWrapper = ErrorWrapper.init(errorTitle: "Sorry! No results found...", errorBody: "Please try a different search request or browse businesses from the list.")
                        }
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
            .sink(receiveCompletion: { [unowned self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error as JSONParsingService.SessionError):
                    assignError(with: error)
                case .failure(let error):
                    self.errorWrapper = ErrorWrapper.init(error: error, errorTitle: "Received unknown error: \(error.localizedDescription)", errorBody: "Please try again later.")
                }
            }) { [unowned self] (result: Vendors) in
                self.vendors = []
                result.vendors.forEach {
                    self.vendors.append(mapVendorCardViewItem(with: $0))
                }
                self.errorWrapper = nil
                completion()
            }
            .store(in: &cancellables)
    }
    
    func assignError(with error: JSONParsingService.SessionError) {
        switch error {
        case .missingDataError:
            self.errorWrapper = ErrorWrapper.init(error: error, errorTitle: "Oops, the data is missing.", errorBody: "Please try again later.")
        case .timeoutError:
            self.errorWrapper = ErrorWrapper.init(error: error, errorTitle: "Oops, the request has timed out.", errorBody: "Please check your connection.")
        case .internalServerError:
            self.errorWrapper = ErrorWrapper.init(error: error, errorTitle: "Oops, there is internal service error.", errorBody: "Please try again later.")
        case .notFound:
            self.errorWrapper = ErrorWrapper.init(error: error, errorTitle: "Oops, the data is not found.", errorBody: "Please try again later.")
        case .requestError:
            self.errorWrapper = ErrorWrapper.init(error: error, errorTitle: "Oops, there is request error.", errorBody: "Please try again later.")
        case .decodingError(_):
            self.errorWrapper = ErrorWrapper.init(error: error, errorTitle: "Oops, we received decoding error.", errorBody: "Please try again later.")
        }
    }
    
    func mapVendorCardViewItem(with vendor: Vendor) -> VendorCardViewItem {
        VendorCardViewItem(id: vendor.id,
                           favorited: vendor.favorited,
                           companyName: vendor.companyName,
                           areaServed: vendor.areaServed,
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
