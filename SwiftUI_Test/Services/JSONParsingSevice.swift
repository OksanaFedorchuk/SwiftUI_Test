//
//  JSONParsingSevice.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 24.04.2023.
//

import Foundation
import Combine

struct JSONParsingService {
    enum SessionError: Error {
        case statusCode(HTTPURLResponse)
        case decodingError(Error)
    }
    
    /// Function that wraps the existing dataTaskPublisher method and attempts to decode the result and publish it
    /// - Parameter url: The URL to be retrieved.
    /// - Returns: Publisher that sends a DecodedResult if the response can be decoded correctly.
    func dataTaskPublisher<T: Decodable>(for url: URL) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ (data, response) -> Data in
                if let response = response as? HTTPURLResponse,
                   (200..<300).contains(response.statusCode) == false {
                    throw SessionError.statusCode(response)
                }
                
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return SessionError.decodingError(error)
            }
            .eraseToAnyPublisher()
    }
}
