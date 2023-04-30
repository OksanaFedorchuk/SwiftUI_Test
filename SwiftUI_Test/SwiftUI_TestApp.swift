//
//  SwiftUI_TestApp.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 24.04.2023.
//

import SwiftUI
import SDWebImage
import SDWebImageSVGCoder

@main
struct SwiftUI_TestApp: App {
    let viewModel = VendorsListVM(dataReceiver: JSONParsingService())
    
    init() {
        setUpSVGCoder()
    }
    
    var body: some Scene {
        WindowGroup {
            VendorsSearchListView(viewModel: viewModel)
        }
    }
}

// Initialize SVGCoder
private extension SwiftUI_TestApp {
    func setUpSVGCoder() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
}
