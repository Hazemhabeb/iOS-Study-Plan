//
//  Quote.swift
//  QuotesViewe_MVVVM
//
//  Created by hazemhabeb on 24/10/2025.
//
import Foundation


struct Quote : Identifiable , Codable {
    let id = UUID()
    let quote : String
    let author : String?
    
    enum CodingKeys : String , CodingKey {
        case quote
        case author
    }
}
