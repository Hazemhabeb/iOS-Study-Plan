//
//  QuoteResponse.swift
//  QuotesViewe_MVVVM
//
//  Created by hazemhabeb on 24/10/2025.
//

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
