import UIKit
import Foundation

//MARK: - Step 7 — async/await Migration

func downloadImageAsync(url : URL) async -> Data? {
    
    do {
        let (data,_) = try await URLSession.shared.data(from: url)
        return data
    }catch {
        print("Error : \(error)")
        return nil
    }
}


let start = Date()

Task {
    let data = await downloadImageAsync(url: URL(string: "https://picsum.photos/200")!)
    print("Async / Await took : \(Date().timeIntervalSince(start)) sec")
    
}
