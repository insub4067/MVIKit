# 🔄 MVIKit

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

struct ContentView: Mviable {
    
    @StateObject var store: Store<ContentModel, ContentIntent>
    
    var body: some View {
        VStack {
            Text("\(model.count)")
            Button("Button", action: { intent.send(.didTap) })
        }
        .padding()
    }
    
    static func build() -> Self {
        let model = ContentModel()
        let intent = ContentIntent()
        return .init(
            store: .init(
                model: model,
                intent: intent,
                modelChangePublisher: model.objectWillChange
            )
        )
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

    var model: ContentModel?
    
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
