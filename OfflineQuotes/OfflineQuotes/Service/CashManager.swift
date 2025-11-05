//
//  CashManager.swift
//  OfflineQuotes
//
//  Created by hazemhabeb on 05/11/2025.
//
import Foundation

protocol Casheable {
    associatedtype T : Codable
    func save(_ data :T , for key : String)
    func load(for key : String) -> T?
}

final class CashManager<T : Codable> : Casheable {
    private let fileManager = FileManager.default
    private var cashURL : URL {
        let dir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        return dir.appendingPathExtension("cashe.json")
    }
    
    func save(_ data: T, for key: String) {
        do {
            let jsonData = try JSONEncoder().encode(data)
            try jsonData.write(to: cashURL)
            print("💥 Data cashed successfully")
        }catch {
            print("❌ Failed to cashe data : \(error)")
        }
    }
    
    func load(for key: String) -> T? {
        do {
            let data = try Data(contentsOf: cashURL)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            print("💥 Cashed loaded successfully")
            return decoded
        }catch {
            print("❌ No Cashed Found or failed to load : \(error)")
            return nil
        }
    }
}
