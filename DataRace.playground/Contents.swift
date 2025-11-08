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
//MARK: -1 Fixing with Serial Queue

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

//MARK: -2 Fixing with NSLock / NSRecursiveLock

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

//MARK: -3 Swift Concurrency way : @Sendable and Actors

func perform (_ closure : @escaping @Sendable () -> Void) {
    DispatchQueue.global().async(execute: closure)
}
///If your closure captures non-thread-safe variables, compiler warns you.
///Helps prevent hidden data races.
///

//MARK: 6-Actors Modern Thread Save Model

///swift actors automatically provide mutual exclusion for their internal state
///"Classes that guarantee thread safety — only one task can access their properties at a time."
///
//Example — Broken Version (Without Actor)

class CounterWithoutActor {
    var value = 0
}

let counter2 = CounterWithoutActor()

Task.detached {
    for _ in 0..<1000 { counter2.value += 1 }
}

Task.detached {
    for _ in 0..<1000 { counter2.value += 1 }
}

Task {
    try await Task.sleep(nanoseconds: 500_000_000)
    print("🔴 Corrupted Value: \(counter2.value)")
}

//MARK: Fixed Version with Actor

actor CounterActor {
    var value = 0
    
    func increment() {
        value += 1
    }
    
    func getValue() -> Int{
        return value
    }
}

let safeActor = CounterActor()

Task.detached {
    for _ in 0..<1000 { await safeActor.increment() }
}

Task.detached {
    for _ in 0..<1000 { await safeActor.increment() }
}

Task {
    try await Task.sleep(nanoseconds: 500_000_000)
    print("🔵 Actor Safe Value: \(await safeActor.getValue())") //Always 2000
}
///💡 The actor ensures all access is serialized automatically.
///You never need locks, barriers, or queues.
