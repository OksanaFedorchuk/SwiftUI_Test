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
        VStack {
            searchBar
            vendorsList
        }
        .padding(.horizontal, 16)
        .background(Color("BackgroundColor"))
    }
}

// MARK: -  SearchBar
private extension VendorsListView {
    var searchBar: some View {
        HStack {
            TextField("Search...", text: $viewModel.searchText)
                .font(Font.system(size: 21))
                .foregroundColor(Color("GreySecondary"))
            Spacer()
            Image("iconSearch")
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 14, y: 6)
    }
}

// MARK: -  VendorsList
private extension VendorsListView {
    var vendorsList: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.vendors, id: \.self) { vendor in
                    VStack(spacing: 20) {
                        VendorCardView(imageURLString: vendor.coverURLString,
                                       locationName: vendor.areaServed,
                                       name: vendor.companyName,
                                       categories: vendor.categories,
                                       tags: vendor.tags)
                    }
                    .padding(.vertical, 12)
                }
            }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VendorsListView(viewModel: VendorsListVM())
    }
}
