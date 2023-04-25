//
//  VendorsParsingModel.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 24.04.2023.
//

import Foundation

// MARK: - Vendors
struct Vendors: Decodable {
    let vendors: [Vendor]
}

// MARK: - Vendor
struct Vendor: Decodable, Equatable {
    let id: Int
    let companyName, areaServed, shopType: String
    let favorited, follow: Bool
    let businessType: String
    let ImageAsset: ImageAsset
    let categories: [Category]
    let tags: [Tag]

    enum CodingKeys: String, CodingKey {
        case id
        case companyName = "company_name"
        case areaServed = "area_served"
        case shopType = "shop_type"
        case favorited, follow
        case businessType = "business_type"
        case ImageAsset = "cover_photo"
        case categories, tags
    }
    
    static func == (lhs: Vendor, rhs: Vendor) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Category
struct Category: Decodable {
    let id: Int
    let name: String
    let image: ImageAsset
}

// MARK: - ImageAsset
struct ImageAsset: Decodable {
    let id: Int
    let mediaURL: String
    let mediaType: MediaType

    enum CodingKeys: String, CodingKey {
        case id
        case mediaURL = "media_url"
        case mediaType = "media_type"
    }
}

enum MediaType: String, Decodable {
    case image = "image"
}

// MARK: - Tag
struct Tag: Decodable {
    let id: Int
    let name, purpose: String
}
