//
//  CategoryView.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 26.04.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryView: View {
    @State var iconURLString: String
    @State var categoryName: String
    
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

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(iconURLString: "https://media-staging.chatsumer.app/48/1830f855-6315-4d3c-a5dc-088ea826aef2.svg",
                     categoryName: "Cafe & Restaurant")
    }
}
