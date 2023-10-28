# MVIKit

> This Package support MVI framework for SwiftUI

## View
```swift
import SwiftUI
import MVIKit

struct ContentView: Viewable {
    
    @StateObject var container: Container<ContentModel, ContentIntent>

    typealias Model = ContentModel
    typealias Intent = ContentIntent
    
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
        return ContentView(
            container: .init(
                model: model,
                intent: intent,
                modelChangePublisher: model.objectWillChange
            )
        )
    }
}
```

## Model, Intent
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

    typealias Model = ContentModel
    
    enum Action {
        case didTap
    }
}
```
