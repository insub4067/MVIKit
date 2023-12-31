# 🔄 MVIKit

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Static Badge](https://img.shields.io/badge/iOS-v13-blue)
![Static Badge](https://img.shields.io/badge/Swift-5.4-orange)

## What is MVI and MVIKit?
[Hannes Dorfmann - MVI](https://hannesdorfmann.com/android/mosby3-mvi-1/)  
> **MVI** - unidirectional architecture found by Hannes Dorfmann for Android.  
> **MVIKit** - a package to help implement MVI easily into SwwiftUI and UIKit

## 🛠️ How it works
> Store - stores instance of reducer and model  
> Reducer - interact with user's action  
> Model - data for ui
<img width="543" alt="스크린샷 2023-10-29 오후 12 33 50" src="https://github.com/insub4067/MVIKit/assets/85481204/c8bd69d5-bd3f-4025-8457-7fedda9fd4ca">


## ✔️ Counter Example - SwiftUI
```swift
import SwiftUI
import MVIKit

struct CounterView: View {
    
    @StateObject var store = Store(with: Counter()) { .init() }
    
    var body: some View {
        VStack(content: {
            Text("\(store.count)")
            Button("button") {
                store.send(.didTap)
            }
        })
    }
}

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

## ✔️ Counter Example - UIKit
```swift
import UIKit
import MVIKit
import Combine

class ViewController: UIViewController { 

    let store = Store(with: Counter()) { .init() }
    var cancellable = Set<AnyCancellable>()
    
    lazy var count: UILabel = {
        let label = UILabel()
        label.text = "\(self.store.count)"
        ...
        return label
    }()

    lazy var button: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
            self.store.send(.didTap)
        }))
        ...
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ...
        bind()
    }

    func bind() {
        store.$count
            .receive(on: DispatchQueue.main)
            .sink { value in
                self.count.text = "\(value)"
            }.store(in: &cancellable)
    }
}

class Counter: Reduceable {
    
    var model: Model?
    
    func reduce(_ action: Action) {
        switch action {
        case .didTap:
            model?.count += 1
        }
    }
    
    class Model: ObservableObject {
        @Published var count = 0
    }
    
    enum Action {
        case didTap
    }
}
```

## ✔️ TextField Example
```swift
import SwiftUI
import MVIKit

struct SearchView: View {
    
    @StateObject var store = Store(with: Search()) { .init() }
    
    var body: some View {
        VStack(content: {
            TextField(text: $store.model.input) {
                store.send(.textChanged($0))
            } label: {
                Text("Input")
            }
        })
    }
}

class Search: Reduceable {
    
    weak var model: Model?
    
    class Model: ObservableObject {
        @Published var input = ""
    }
    
    enum Action: Equatable {
        case textChanged(String)
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .textChanged(let string):
            print(string)
        }
    }
}
```

## ✔️ TabView Example
```swift 
import SwiftUI
import MVIKit

struct MainTabView: View {
    
    @StateObject var store = Store(with: MainTab()) { .init() }
    
    var body: some View {
    
        TabView(selection: $store.model.currentTab) {
            store.send(.didSelect(tab: $0))
        } content: {
            ForEach(MainTab.Tab.allCases, id: \.self) { tab in
                tab.text
                    .tabItem { tab.text }
                    .tag(tab)
            }
        }
    }
}

class MainTab: Reduceable {
    
    weak var model: Model?
    
    enum Tab: Int, CaseIterable {
        case one, two, three
        var text: Text {
            switch self {
            case .one:
                Text("One")
            case .two:
                Text("Two")
            case .three:
                Text("One")
            }
        }
    }
    
    class Model: ObservableObject {
        @Published var currentTab: Tab = .one
    }
    
    enum Action: Equatable {
        case didSelect(tab: Tab)
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .didSelect(let tab):
            print(tab)
        }
    }
}
```

## ✔️ Scroll Example
```swift 
import SwiftUI
import MVIKit

struct ContentView: View {
    
    @StateObject var store = Store(with: Scroll(), modelBuilder: { .init() })
    
    var body: some View {
        
        ScrollView(
            offsetChanged: { store.send(.didScroll($0)) }
        ) {
            LazyVStack {
                ForEach((0...100), id: \.self) { int in
                    Text("\(int)")
                        .padding()
                }
            }
        }
    }
}

class Scroll: Reduceable {
    
    var model: Model?
    
    func reduce(_ action: Action) {
        switch action {
        case .didScroll(let offset):
            print(offset)
        }
    }

    class Model: ObservableObject {
        
    }
    
    enum Action: Equatable {
        case didScroll(CGFloat)
    }
}
```
