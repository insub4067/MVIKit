# 🔄 MVIKit

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Static Badge](https://img.shields.io/badge/iOS-v13-blue)
![Static Badge](https://img.shields.io/badge/Swift-5.4-orange)

> Help you can implement MVI easily into SwiftUI.

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
    
    @StateObject var store = Store(with: ContentReducer()) { $0.Model() }
    
    var body: some View {
        VStack(content: {
            Text("\(store.count)")
            Button("button") {
                store.send(.didTap)
            }
        })
    }
}
```

### Model, Intent
```swift
import Foundation
import MVIKit

class ContentReducer: Reduceable {
    
    var model: Model?
    
    class Model: Modelable {
        @Published var count = 0
    }

    enum Action: Equatable {
        case didTap
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .didTap:
            model?.count += 1
        }
    }
}
```
