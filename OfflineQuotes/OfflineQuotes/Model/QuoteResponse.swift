//
//  QuoteResponse.swift
//  OfflineQuotes
//
//  Created by hazemhabeb on 05/11/2025.
//
import Foundation

struct QuoteResponse : Codable{
    let quotes : [Quote]
    let total : Int
    let skip : Int
    let limit : Int
    
    enum CodingKeys : String , CodingKey {
        case quotes
        case skip
        case total
        case limit
    }
}
