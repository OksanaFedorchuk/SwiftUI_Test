//
//  ErrorWrapper.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 28.04.2023.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error?
    let errorTitle: String
    let errorBody: String
    
    init(id: UUID = UUID(), error: Error? = nil, errorTitle: String, errorBody: String) {
        self.id = id
        self.error = error
        self.errorTitle = errorTitle
        self.errorBody = errorBody
    }
}
