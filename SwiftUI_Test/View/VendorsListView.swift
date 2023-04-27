//
//  VendorsListView.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 24.04.2023.
//

import SwiftUI
import CoreData

struct VendorsListView: View {
    @ObservedObject var viewModel: VendorsListVM
    
    init(viewModel: VendorsListVM) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.vendors, id: \.self) { vendor in
                    VStack(spacing: 20) {
                        VendorCardView(imageURLString: vendor.coverURLString,
                                       locationTag: vendor.areaServed,
                                       name: vendor.companyName,
                                       categories: vendor.categories,
                                       tags: vendor.tags)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VendorsListView(viewModel: VendorsListVM())
    }
}
