//
//  Quote.swift
//  OfflineQuotes
//
//  Created by hazemhabeb on 05/11/2025.
//
import Foundation

struct Quote : Codable , Identifiable {
    let id = UUID()
    let text : String
    let auther : String?
    
    enum CodingKeys : String , CodingKey {
        case text = "quote"
        case auther = "auther"
    }
}
