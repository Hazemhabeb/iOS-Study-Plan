//
//  AppError.swift
//  OfflineQuotes
//
//  Created by hazemhabeb on 05/11/2025.
//

import Foundation

enum AppError : Error , LocalizedError {
    case network
    case decoding
    case cache
    case unknow(Error)
    
    var errorDescription: String? {
        switch self {
        case .network : return "Network connection lost."
        case .decoding : return "Failed to parse data."
        case .cache : return "Cashe not available."
        case .unknow(let err) : return err.localizedDescription
        }
    }
}
