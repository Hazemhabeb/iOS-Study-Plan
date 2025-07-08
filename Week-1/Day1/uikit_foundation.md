# UIKit Foundation - Deep Dive Notes (Day 1)

## 1. UIView Lifecycle

UIView is the base class for most visual elements. Understanding its lifecycle is crucial.

### Lifecycle Methods:

* `init(frame:)` — Initializes the view in code.
* `awakeFromNib()` — Called when the view is loaded from a XIB or storyboard.
* `layoutSubviews()` — Called when the layout is updated. Override this to modify subviews layout.
* `draw(_:)` — Use this for custom drawing (Core Graphics).

```swift
override func layoutSubviews() {
    super.layoutSubviews()
    // Custom layout here
}
```

---

## 2. UIViewController Lifecycle

UIViewController manages a screen's content. Key lifecycle methods:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    print("Initial setup")
}

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("View will appear")
}

override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print("View did appear")
}

override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("View will disappear")
}

override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    print("View did disappear")
}
```

---

## 3. Storyboard vs Programmatic UI

| Feature  | Storyboard                    | Programmatic UI                   |
| -------- | ----------------------------- | --------------------------------- |
| Pros     | Visual, fast prototyping      | Full control, better for teams    |
| Cons     | Merge conflicts, hidden logic | More verbose, slower at start     |
| Use Case | MVPs, internal tools          | Production apps, reusable modules |

### Team Lead Tip:

Use **programmatic UI** in large teams to avoid merge conflicts and enhance reusability.

---

## 4. Common UIKit Components

### UILabel

```swift
let label = UILabel()
label.text = "Hello, UIKit"
label.textColor = .black
```

### UIButton

```swift
let button = UIButton(type: .system)
button.setTitle("Tap Me", for: .normal)
button.addTarget(self, action: #selector(tapHandler), for: .touchUpInside)
```

### UIImageView

```swift
let imageView = UIImageView(image: UIImage(named: "avatar"))
imageView.contentMode = .scaleAspectFit
```

### UITableView (Minimal)

```swift
class MyViewController: UIViewController, UITableViewDataSource {
    let tableView = UITableView()
    let items = ["One", "Two", "Three"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}
```

---

## 5. Target-Action Pattern

Used with UIControl elements:

```swift
@objc func tapHandler() {
    print("Button tapped")
}
```

---

## 6. Responder Chain

UIKit delivers events via the responder chain:

```
Touch ➜ UIView ➜ UIViewController ➜ UIWindow ➜ UIApplication ➜ AppDelegate
```

You can override:

```swift
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    print("Touch received")
}
```

---

## ✅ Summary

This foundational knowledge is critical for any UIKit-based app. Next, refer to (./UIKitBasicsDemo) for practical code using both Storyboard and Programmatic approaches.

