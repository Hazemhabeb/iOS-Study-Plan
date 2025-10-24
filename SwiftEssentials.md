# Swift Essentials – Notes from Paul Hudson’s Video

This note summarizes key Swift concepts and tips from the video "Learn the Essentials of Swift in One Hour" by Paul Hudson. It is part of the iOS Lead Roadmap.

---

## ✅ Swift Essentials – Key Takeaways

### 📌 1. Variables & Constants

* Use `var` for variables and `let` for constants.
* Prefer `let` for immutability.

```swift
let name = "Hazem"
var age = 30
```

### 📌 2. Type Annotations

* Swift uses type inference, but annotations improve clarity.

```swift
let score: Int = 85
```

### 📌 3. Strings & Interpolation

* Use `\()` for cleaner string formatting.

```swift
let message = "Your score is \(score)"
```

* Multiline strings use triple quotes `"""`.

### 📌 4. Collections: Arrays, Sets, Dictionaries

```swift
let fruits = ["Apple", "Banana"]
let uniqueNumbers: Set<Int> = [1, 2, 2, 3]
let scores = ["Hazem": 95, "Sara": 88]
```

* Use `Set` for uniqueness, `Dictionary` for key-value lookups.

### 📌 5. Enums

```swift
enum Weather {
    case sunny, rainy, cloudy
}
```

* Ideal for finite options.

### 📌 6. Control Flow

* Use `if`, `guard`, `switch`, `for`, and `while`.

```swift
for fruit in fruits {
    print(fruit)
}
```

* Prefer `guard` for cleaner early exits.

### 📌 7. Optionals

```swift
var name: String? = nil
if let name = name {
    print("Hello, \(name)")
}
```

* Avoid force unwrapping (`!`). Use `if let`, `guard let`.

### 📌 8. Functions

```swift
func greet(name: String) -> String {
    return "Hello, \(name)"
}
```

* Use clear names and return types.

### 📌 9. Structs

```swift
struct User {
    var name: String
    var age: Int
}
```

* Lightweight, safer than classes by default.

### 📌 10. Closures

```swift
let sayHello = {
    print("Hello!")
}
sayHello()
```

* Learn trailing closures for SwiftUI and functional programming.

### 📌 11. Error Handling

```swift
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws {
    if password == "123" {
        throw PasswordError.obvious
    }
}
```

* Use `do-try-catch` to handle errors.

### 📌 12. Protocols

```swift
protocol Greetable {
    func greet()
}
```

* Use protocols for flexibility and testability.

### 📌 13. Classes vs Structs

* Use classes when you need:

  * Inheritance
  * Shared mutable state

### 📌 14. Property Observers

```swift
var score = 0 {
    didSet {
        print("Score changed to \(score)")
    }
}
```

* Great for tracking changes and debugging.

---

## 🎓 Apply to iOS  Roadmap

| Topic                 | How to Practice                                  |
| --------------------- | ------------------------------------------------ |
| Constants & Variables | Use `let` by default                             |
| Optionals             | Practice `if let`, `guard let`, `??`             |
| Enums                 | Model fixed categories in your apps              |
| Structs & Functions   | Create reusable components                       |
| Protocols             | Use in delegation and networking layers          |
| Error Handling        | Apply custom error enums for app logic           |
| Closures              | Use with collections (`map`, `filter`, `reduce`) |


