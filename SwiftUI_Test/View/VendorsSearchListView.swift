//
//  VendorsSearchListView.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 24.04.2023.
//

import SwiftUI
import CoreData

struct VendorsSearchListView: View {
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
private extension VendorsSearchListView {
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
private extension VendorsSearchListView {
    var vendorsList: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.vendors.indices, id: \.self) { ind in
                    VStack(spacing: 20) {
                        VendorCardView(isFavorite: $viewModel.vendors[ind].favorited,
                                       imageURLString: viewModel.vendors[ind].coverURLString,
                                       locationName: viewModel.vendors[ind].areaServed,
                                       name: viewModel.vendors[ind].companyName,
                                       categories: viewModel.vendors[ind].categories,
                                       tags: viewModel.vendors[ind].tags)
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
        VendorsSearchListView(viewModel: VendorsListVM())
    }
}
