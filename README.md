# MVIKit

> Help you easily implement MVI into SwiftUI.
<img width="538" alt="스크린샷 2023-10-29 오전 12 23 13" src="https://github.com/insub4067/MVIKit/assets/85481204/d4fe7904-1994-4cbe-97e3-bea552db89a5">

## ✔️ View
```swift
import SwiftUI
import MVIKit

struct ContentView: Viewable {
    
    typealias Model = ContentModel
    typealias Intent = ContentIntent
    
    @StateObject var container: Container<ContentModel, ContentIntent>
    
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
            container: .init(
                model: model,
                intent: intent,
                modelChangePublisher: model.objectWillChange
            )
        )
    }
}
```

## ✔️ Model, Intent
```swift
import Foundation
import MVIKit

class ContentModel: Modelable {
    @Published var count = 0
}

class ContentIntent: Intentable {

    var model: ContentModel?
    
    func send(_ action: Action) {
        model?.count += 1
    }
    
    enum Action {
        case didTap
    }
}
```
