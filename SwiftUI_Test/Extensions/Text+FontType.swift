//
//  MyFonts.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 25.04.2023.
//

import SwiftUI

extension Text {
    enum FontType {
        case title
        case headline
        case subhead
        case body
    }
    
    func font(type: FontType) -> Text {
        switch type {
        case .title:
            return self.font(Font.custom("OpenSans-Bold", size: 24))
        case .headline:
            return self.font(Font.custom("OpenSans-Bold", size: 16))
        case .subhead:
            return self.font(Font.custom("OpenSans", size: 16))
        case .body:
            return self.font(Font.custom("OpenSans", size: 14))
        }
    }
}
