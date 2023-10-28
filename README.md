# 🔄 MVIKit

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Static Badge](https://img.shields.io/badge/iOS-v13-blue)
![Static Badge](https://img.shields.io/badge/Swift-5.4-orange)

> Help you easily implement MVI into SwiftUI.

## 🛠️ How it works
### Store - Stores instance of intent and model. 
### Intent - Interact with user's action 
### Model - Data for ui
<img width="530" alt="스크린샷 2023-10-29 오전 1 11 20" src="https://github.com/insub4067/MVIKit/assets/85481204/99e7264a-13cc-4eb4-bc79-91c3d36bde61">

## ✔️ Example
### View
```swift
import SwiftUI
import MVIKit

struct ContentView: View {
    
    @StateObject var store = Store(with: ContentIntent()) {
        ContentModel()
    }
    private var model: ContentModel { store.model }
    
    var body: some View {
        VStack {
            Text("\(model.count)")
            Button("Button", action: { store.send(.didTap) })
        }
        .padding()
    }
}
```

### Model, Intent
```swift
import Foundation
import MVIKit

class ContentModel: Modelable {
    @Published var count = 0
}

class ContentIntent: Intentable {

    weak var model: ContentModel?
    
    func send(_ action: Action) {
        switch action {
        case .didTap:
            model?.count += 1
        }
    }
    
    enum Action {
        case didTap
    }
}
```
