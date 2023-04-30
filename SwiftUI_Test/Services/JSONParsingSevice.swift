//
//  JSONParsingSevice.swift
//  SwiftUI_Test
//
//  Created by Oksana Fedorchuk on 24.04.2023.
//

import Foundation
import Combine

protocol DataProviding {
    func dataTaskPublisher<T: Decodable>(for url: URL) -> AnyPublisher<T, Error>
}

struct JSONParsingService: DataProviding {
    enum SessionError: Error {
        case missingDataError
        case timeoutError
        case internalServerError
        case notFound
        case requestError
        case decodingError(Error)
    }
    enum Status: Int {
        case notFound = 404
        case requestTimeout = 408
        case internalServerError = 500
    }
    
    /// Function that wraps the existing dataTaskPublisher method and attempts to decode the result and publish it
    /// - Parameter url: The URL to be retrieved.
    /// - Returns: Publisher that sends a DecodedResult if the response can be decoded correctly.
    func dataTaskPublisher<T: Decodable>(for url: URL) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ (data, response) -> Data in
                if let response = response as? HTTPURLResponse,
                   (200..<300).contains(response.statusCode) == false {
                    switch Status(rawValue: response.statusCode) {
                    case .requestTimeout:
                        throw SessionError.timeoutError
                    case .internalServerError:
                        throw SessionError.internalServerError
                    case .notFound:
                        throw SessionError.notFound
                    default:
                        throw SessionError.requestError
                    }
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
