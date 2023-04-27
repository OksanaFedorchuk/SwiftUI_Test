//
//  VendorCardView.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 25.04.2023.
//

import SwiftUI
import SDWebImageSwiftUI

/// Cell used in Vendors list screen.
struct VendorCardView: View {
    var imageURLString: String
    var locationName: String
    var name: String
    var categories: [CategoryViewItem]
    var tags: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {
                asyncCoverImage
                locationTag
            }
            vendorNameText
            categoriesHGrid
            tagsText
        }
    }
}

// MARK: - AsyncCoverImage
private extension VendorCardView {
    var asyncCoverImage: some View {
        AsyncImage(url: URL(string: imageURLString)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: 170)
        }
        .scaledToFill()
        .frame(maxHeight: 170)
        .cornerRadius(10)
        .clipped()
    }
}

// MARK: - LocationTag
private extension VendorCardView {
    var locationTag: some View {
        Text(locationName)
            .font(type: .body)
            .foregroundColor(Color("GreyPrimary"))
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(.white).opacity(90)
            .cornerRadius(16)
            .padding([.leading, .bottom], 8)
    }
}

// MARK: - VendorNameText
private extension VendorCardView {
    var vendorNameText: some View {
        Text(name)
            .font(type: .headline)
            .foregroundColor(Color("GreyPrimary"))
    }
}

// MARK: - CategoriesHGrid
private extension VendorCardView {
    var categoriesHGrid: some View {
        LazyHGrid(rows: rows(), spacing: 10) {
            ForEach(categories, id: \.self) { category in
                HStack {
                    CategoryView(iconURLString: category.iconURLString,
                                 categoryName: category.name)
                    Spacer()
                }
            }
        }
        .frame(height: categoriesHeight())
    }
    
    private func categoriesHeight() -> CGFloat {
        let rows = rows().count
        return CGFloat(rows * 22)
    }
    
    private func rows() -> [GridItem] {
        guard categories.count > 1 else {
            return [GridItem(.adaptive(minimum: 40))]
        }
        var rows = categories.count / 2
        var items = [GridItem]()
        while rows > 0 {
            items.append(GridItem(.adaptive(minimum: 40)))
            rows -= 1
        }
        return items
    }
    
    private struct CategoryView: View {
        var iconURLString: String
        var categoryName: String
        
        var body: some View {
            Grid {
                GridRow {
                    WebImage(url: URL(string: iconURLString),
                             context: [.imageThumbnailPixelSize : CGSize.zero])
                    .resizable()
                    .frame(minWidth: 21, maxWidth: 21.34, minHeight: 21, maxHeight: 22)
                    
                    Text(categoryName)
                        .font(type: .body)
                        .foregroundColor(Color("GreyPrimary"))
                }
                
            }
        }
    }
}

// MARK: - TagsText
private extension VendorCardView {
    var tagsText: some View {
        Text("• \(tags.joined(separator: " • "))")
            .font(type: .body)
            .foregroundColor(Color("GreySecondary"))
    }
}

// MARK: - Preview
struct VendorCardView_Previews: PreviewProvider {
    static var previews: some View {
        VendorCardView(imageURLString: "https://i.imgur.com/OnwEDW3.jpg", locationName: "Newport", name: "Shop name",
                       categories: [CategoryViewItem (id: 0, name: "Cafe & Restaurant", iconURLString: "https://media-staging.chatsumer.app/48/1830f855-6315-4d3c-a5dc-088ea826aef2.svg"), CategoryViewItem (id: 0, name: "Cafes & Restaurants", iconURLString: "https://media-staging.chatsumer.app/48/1830f855-6315-4d3c-a5dc-088ea826aef2.svg")], tags: ["Teasjnf wlekfnq", "qhewbflwe", "qekwfjnrq wir[e2 pekfko"])
    }
}
