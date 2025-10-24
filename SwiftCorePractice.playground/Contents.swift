// MARK: - ARC Example: Strong Reference Cycle
import Foundation

class User {
    let name : String
    var phone : Phone?
    init(name: String) {self.name = name}
    deinit { print("❌ user \(name) deinitialized") }
}

class Phone {
    let number : String
    var owner : User?
    init(number: String, owner: User? = nil) {self.number = number}
    deinit { print("❌ phone \(number) deintialized") }
}

// Create the retain cycle
var user : User? = User(name: "hazem")
var phone : Phone? = Phone(number: "+201000000000")

user?.phone = phone
phone?.owner = user //  ❗️ Strong reference cycle

//break refrence
user = nil
phone = nil
//Both object will not be deintialized because they retain cycle each other .

//MARK: - here to show the fixes to avoid it using weak

class PhoneFixed {
    let number : String
    weak var owner : UserFixed? // weak breaks the cycle
    init(number : String) {self.number =  number}
    deinit{print("📱 phone \(number) is deintialized")}
}

class UserFixed {
    let name : String
    var phone : PhoneFixed?
    init(name:String){self.name = name}
    deinit{print("👤 user \(name) is deintialized")}
}

var userFixed : UserFixed? = UserFixed(name: "hazem")
var phoneFixed : PhoneFixed? = PhoneFixed(number: "+200000000")

userFixed?.phone = phoneFixed
phoneFixed?.owner = userFixed


userFixed = nil
phoneFixed = nil
//here both is being deintialized and memory released

/**
 I used weak on one side of the relationship (Phone → User) because the Phone doesn’t own the User.
 This prevents the retain cycle, allowing both objects to deinitialize properly.
 */

//MARK: - Escaping closure + [weak self]

class DataFetcher {
    var completion : (@Sendable () -> Void )? // @Sendable this stric from swift 6 Store a completion handler — mark it @Sendable since it may be executed off the main thread
    
    func fetchData(completion : @escaping @Sendable () -> Void) {
        self.completion = completion
        
        DispatchQueue.global().asyncAfter(deadline: .now()) {
            completion()
        }
    }
}

@MainActor
final class ViewController {
    var data = "Some data"
    
    func startFetching () {
        var fetcher = DataFetcher()
        
        fetcher.fetchData { [weak self] in
            // Hop back to main actor explicitly (since we’re inside a background @Sendable closure)
            Task { @MainActor in
                guard let self else { return }
                print("successfully fetched \(self.data)")
            }
        }
    }
    
    deinit{ print("💥 viewController deintialized") }
}

var vc : ViewController? = ViewController()
vc?.startFetching()

//make sleep till the fetching is finished 
Task {
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    vc = nil
}

