//
//  ContentView.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 24.04.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var viewModel: VendorsListVM

    init(viewModel: VendorsListVM) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.vendors, id: \.self) { vendor in
                    Text("Vendor: \(vendor.companyName), business type: \(vendor.businessType)")
                }
            }
            .onAppear {
                print("\(String(describing: viewModel.vendors))")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: VendorsListVM())
    }
}
