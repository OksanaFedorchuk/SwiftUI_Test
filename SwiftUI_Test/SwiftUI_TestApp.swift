//
//  SwiftUI_TestApp.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 24.04.2023.
//

import SwiftUI

@main
struct SwiftUI_TestApp: App {
    let viewModel = VendorsListVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
