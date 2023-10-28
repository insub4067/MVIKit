//
//  MVIContainer.swift
//  SwiftUIPractice
//
//  Created by 김인섭 on 10/28/23.
//

import Foundation
import Combine

final class Container<Model: Modelable, Intent: Intentable>: ObservableObject {
    
    let model: Model
    let intent: Intent
    
    private var cancellable = Set<AnyCancellable>()
    
    init(
        model: Model,
        intent: Intent,
        modelChangePublisher: ObjectWillChangePublisher
    ) {
        self.intent = intent
        self.intent.model = model as? Intent.Model
        self.model = model
        
        modelChangePublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancellable)
    }
}
