//
//  VendorCardViewItem.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 24.04.2023.
//

import Foundation

/// View content item, which contains the needed data
/// to render vendor list card.
struct VendorCardViewItem {
    let id: Int
    var favorited: Bool
    let companyName, areaServed: String
    let coverURLString: String
    let categories: [CategoryViewItem]
    let tags: [String]
}

// MARK: - Equatable
extension VendorCardViewItem: Equatable {
    static func == (lhs: VendorCardViewItem, rhs: VendorCardViewItem) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Hashable
extension VendorCardViewItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
