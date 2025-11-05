//
//  QuotesRepository.swift
//  OfflineQuotes
//
//  Created by hazemhabeb on 05/11/2025.
//
import Foundation

final class QuotesRepository {
    private let network : NetworkServiceProtocol
    private let cashe : CashManager<[Quote]>
    private let casheKey  = "quotes_cashe"
    
    init(network: NetworkServiceProtocol, cashe: CashManager<[Quote]>) {
        self.network = network
        self.cashe = cashe
    }
    
    func getQuotes(forceRefresh : Bool = false) async throws -> [Quote] {
        if !forceRefresh , let cashed = cashe.load(for: casheKey) {
            print("💥 loaded from cashe")
            return cashed
        }
        
        
        do {
            let quotes = try await network.fetchQuotes()
            cashe.save(quotes, for: casheKey)
            return quotes
        } catch let urlError as URLError {
            throw AppError.network
        }catch let decodingError as DecodingError {
            throw AppError.decoding
        }catch {
            throw AppError.unknow(error)
        }
       
    }
}
