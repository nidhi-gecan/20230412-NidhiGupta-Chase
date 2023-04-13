//
//  NetworkError.swift
//  20230412-NidhiGupta-Chase
//
//  Created by Nidhi Gupta on 13/04/23.
//

import Foundation

enum NetworkError: Error {
    case serverError(statusCode: Int)
    case notFound(message: String)
    case decodingError(error:Error)
    case unexpected(error: Error)
}

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch(self){
        case .serverError(let statusCode):
            return "Server Error: \(statusCode)"
        case .notFound(let message):
            return "\(message)"
        case .decodingError(let error):
            return "Decoding Error: \(error)"
        case .unexpected(let error):
            return "\(error.localizedDescription)"
        }
    }
}


