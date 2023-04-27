//
//  VendorCardView.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 25.04.2023.
//

import SwiftUI

struct VendorCardView: View {
    @State var imageURLString: String
    @State var locationTag: String
    @State var name: String
    @State var categories: [CategoryViewItem]
    @State var tags: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {
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
                
                
                Text(locationTag)
                    .font(type: .body)
                    .foregroundColor(Color("GreyPrimary"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(.white).opacity(90)
                    .cornerRadius(16)
                    .padding([.leading, .bottom], 8)
            }
            Text(name)
                .font(type: .headline)
                .foregroundColor(Color("GreyPrimary"))
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
            Text("• \(tags.joined(separator: " • "))")
                .font(type: .body)
                .foregroundColor(Color("GreySecondary"))
        }
    }
    
    func categoriesHeight() -> CGFloat {
        let rows = rows().count
        return CGFloat(rows * 22)
    }
    
    func rows() -> [GridItem] {
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
}

struct VendorCardView_Previews: PreviewProvider {
    static var previews: some View {
        VendorCardView(imageURLString: "https://i.imgur.com/OnwEDW3.jpg", locationTag: "Newport", name: "Shop name",
                       categories: [CategoryViewItem (id: 0, name: "Cafe & Restaurant", iconURLString: "https://media-staging.chatsumer.app/48/1830f855-6315-4d3c-a5dc-088ea826aef2.svg"), CategoryViewItem (id: 0, name: "Cafes & Restaurants", iconURLString: "https://media-staging.chatsumer.app/48/1830f855-6315-4d3c-a5dc-088ea826aef2.svg")], tags: ["Teasjnf wlekfnq", "qhewbflwe", "qekwfjnrq wir[e2 pekfko"])
    }
}
