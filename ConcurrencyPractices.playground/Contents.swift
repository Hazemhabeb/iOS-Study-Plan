import Foundation
//MARK: 1- Serial Queue
let serialQueue = DispatchQueue(label : "com.hazem.serial")

for i in 1...3 {
    serialQueue.async {
        print("🔵 Serial Task \(i) - Tread : \(Thread.current)")
        sleep(1)
    }
}
///➡️ Output: Tasks run one after another (FIFO).
///Perfect for protecting shared data (thread safety).

//MARK: 2- Concurrent Queue
let concurrentQueue = DispatchQueue(label : "com.hazem.concurrent",attributes: .concurrent)

for i in 1...3 {
    concurrentQueue.async {
        print("🟢 Concurrent Task \(i) - Thread: \(Thread.current)")
        sleep(1)
    }
}
///➡️ Output: Tasks run in parallel, each possibly on a different thread.

//MARK: 3- Concurrent Queue
let queue = DispatchQueue.global(qos: .userInitiated)
queue.async {
    print("💥 High priority task running...")
}
///Quality of Service (QoS)
///QoS defines how important a task is: .userInteractive /  .userInitiated /  .utility / .background

//MARK: 4- DipatchGroup (waiting for multiple tasks)
let group = DispatchGroup()

for i in 1...5 {
    group.enter()
    DispatchQueue.global().async {
        print("🟠 Task \(i) started")
        sleep(2)
        print("🟠 Task \(i) done")
        group.leave()
    }
}

group.wait()
print("🟠 All done")
///➡️ DispatchGroup is used when you need to run multiple async tasks and then wait for all to finish — great for API batching or asset preloading.

//MARK: 5-DispatchSemaphore (Throttling)

let semaphore = DispatchSemaphore(value: 2)//Max 2 concurrent

for i in 1...5 {
    DispatchQueue.global().async {
        semaphore.wait() // take a slot
        print("🟣 Running task \(i)")
        sleep(2)
        print("🟣 Finished task\(i)")
        semaphore.signal() //release slot
        
    }
}
///➡️ Perfect for rate limiting (e.g., API requests, image downloads).
 
