# 🔄 MVIKit

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Static Badge](https://img.shields.io/badge/iOS-v13-blue)
![Static Badge](https://img.shields.io/badge/Swift-5.4-orange)

## What is MVI and MVIKit?
[Hannes Dorfmann - MVI](https://hannesdorfmann.com/android/mosby3-mvi-1/)  
> **MVI** - unidirectional architecture found by Hannes Dorfmann for Android.  
> **MVIKit** - a package to help implement MVI easily into SwiftUI.  

## 🛠️ How it works
> Store - stores instance of reducer and model  
> Reducer - interact with user's action  
> Model - data for ui
<img width="543" alt="스크린샷 2023-10-29 오후 12 33 50" src="https://github.com/insub4067/MVIKit/assets/85481204/c8bd69d5-bd3f-4025-8457-7fedda9fd4ca">


## ✔️ Example
### View
```swift
import SwiftUI
import MVIKit

struct CounterView: View {
    
    @StateObject var store = Store(with: Counter()) { $0.Model() }
    
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

### Reducer - Model, Action
```swift
import Foundation
import MVIKit

class Counter: Reduceable {

    class Model: ObservableObject {
        @Published var count = 0
    }
    
    enum Action: Equatable {
        case didTap
    }
    
    weak var model: Model?
    
    func reduce(_ action: Action) {
        switch action {
        case .didTap:
            model?.count += 1
        }
    }
}
```
