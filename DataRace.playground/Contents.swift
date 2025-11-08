import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

class Counter {
    var value = 0
}

let counter = Counter()

DispatchQueue.global().async {
    for _ in 0..<1000{
        counter.value += 1
    }
}

DispatchQueue.global().async {
    for _ in 0..<1000 {
        counter.value += 1
    }
}

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    print("❌ Final value :\(counter.value)") // unpredictable
}

//this is example of what is the data race is
//MARK: - Fixing with Serial Queue

class SafeCounter {
    private var value = 0
    private let queue = DispatchQueue(label :"com.hazem.safeCounter")
    
    func increment() {
        queue.async {
            self.value += 1
        }
    }
    
    func getValue(completion : @escaping (Int) -> Void) {
        queue.async {
            completion(self.value)
        }
    }
}

let safeCounter = SafeCounter()

for _ in 0..<1000 {
    DispatchQueue.global().async {
        safeCounter.increment()
    }
}

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    safeCounter.getValue { value in
        print("✅ Safe Counter Value : \(value)") //Always 1000
    }
}
//MARK: - fixing with Dipatch Barrier

class BarrierCounter {
    private var value = 0
    private let queue = DispatchQueue(label: "com.hazem.barrierCounter",attributes: .concurrent)
    
    
    func increment() {
        queue.async(flags: .barrier){ // 🔐 barrier = exclusive access
            self.value += 1
        }
    }
    
    func getValue() -> Int {
        var result = 0
        queue.sync {
            result = value
        }
        return result
    }
}

let barrierCounter = BarrierCounter()

for _ in 0..<1000 {
    DispatchQueue.global().async {
        barrierCounter.increment()
    }
}

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    print("🟣 barrier Counter Value : \( barrierCounter.getValue())") //Always 1000
}

//MARK: Fixing with NSLock / NSRecursiveLock

class LockedCounter {
    private var value = 0
    private let lock = NSLock()
    
    func increment() {
        lock.lock()
        value += 1
        lock.unlock()
    }
    
    func getValue() -> Int {
        lock.lock()
        let v = value
        lock.unlock()
        return v
    }
}

let lockedCounter = LockedCounter()

for _ in 0..<1000 {
    DispatchQueue.global().async {
        lockedCounter.increment()
    }
}

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    print("🟠 locked counter Value : \( lockedCounter.getValue())") //Always 1000
}
///✅ Works but must be handled carefully — forgetting unlock causes deadlocks.
///NSRecursiveLock
///Used if a thread might lock the same lock multiple times recursively.

