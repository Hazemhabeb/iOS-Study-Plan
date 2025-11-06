//MARK: 6- OperationQueue vs GCD Comparison

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


//MARK: - Helper Logger
func log(_ message : String) {
    let thread = Thread.isMainThread ? "🟢 Main Thread " : "⚙️ Background Thread"
    print("\(thread) : \(message)")
}

//MARK: - Test URL
let testURL = URL(string:"https://picsum.photos/300")!

//=================================================
//MARK: 1️⃣ GCD Example
//=================================================

func downloadImageWithGCD(url : URL , completion: @escaping (Data?) -> Void) {
    let startTime = Date()
    log("Starting GCD download...")
    
    DispatchQueue.global(qos: .utility).async {
        let data = try?  Data(contentsOf: url)
        let elapsed = String(format : "%.2f",Date().timeIntervalSince(startTime))
        log("Finished GCD download in \(elapsed)")
        DispatchQueue.main.async {
            completion(data)
        }
    }
}
downloadImageWithGCD(url: testURL){ data in
    if let data = data {
        log("✅ GCD finished : downloaded image size \(data.count) bytes")
    }else {
        log("❌ GCD download failed")
    }
}
//====================================================
// MARK : 2️⃣ OperationQueue Example
//===================================================

class ImageDownloadOperation : Operation {
    let url : URL
    var imageData : Data?
    
    init(url : URL){
        self.url = url
    }
    
    override func main() {
        if isCancelled {
            log("❌ Operation cancelled before start")
            return
        }
        let startTime = Date()
        log("Starting OperationQueue download...")
        imageData = try? Data(contentsOf: url)
        
        
        let elapsed = String(format: "%.2f", Date().timeIntervalSince(startTime))
        log("Finished OperationQueue download in \(elapsed)s")
    }
}

//Create the queue
let queue = OperationQueue()
queue.maxConcurrentOperationCount = 2


//Create  operations
let downloadOp = ImageDownloadOperation(url: testURL)

let resizeOp = BlockOperation {
    if downloadOp.isCancelled {
        log("❌ Resize skipped - download was cancelled")
        return
    }
    guard let data = downloadOp.imageData else {
        log("❌ no data found in resize operation")
        return
    }
    log("🪄 Resizing image \(data.count) bytes")
}
resizeOp.addDependency(downloadOp) //Make resize wait for download


//completion block for the queue
resizeOp.completionBlock = {
    log("✅ Resize operation finished successfully")
    PlaygroundPage.current.finishExecution()
}

//Add all operations
queue.addOperations([downloadOp,resizeOp], waitUntilFinished: false)

//Uncomment to test the cancellation
DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
    log("⚠️ Cancelling download operation....")
    downloadOp.cancel()
}
