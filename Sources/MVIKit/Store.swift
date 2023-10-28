//
//  Store.swift
//  SwiftUIPractice
//
//  Created by 김인섭 on 10/28/23.
//

#if canImport(Combine)
import Foundation
import Combine

public final class Store<Model: Modelable, Intent: Intentable>: ObservableObject {
    
    @Published public var model: Model
    public let intent: Intent
    
    private var cancellable = Set<AnyCancellable>()
    
    public init(
        model: Model,
        intent: Intent
    ) {
        self.intent = intent
        self.intent.model = model as? Intent.Model
        self.model = model
        
        model.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellable)
    }
}
#endif
