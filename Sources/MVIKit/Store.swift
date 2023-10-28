//
//  Store.swift
//  SwiftUIPractice
//
//  Created by 김인섭 on 10/28/23.
//

#if canImport(Combine)
import Foundation
import Combine

@dynamicMemberLookup
public final class Store<Model: Modelable, Intent: Intentable>: ObservableObject {
    
    @Published public var model: Model
    public let intent: Intent
    
    private var cancellable = Set<AnyCancellable>()
    
    public init(
        with intent: Intent,
        modelBuilder: () -> Model
    ) {
        self.model = modelBuilder()
        self.intent = intent
        self.intent.model = self.model as? Intent.Model
        
        model.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellable)
    }
    
    public func send(_ action: Intent.Action) {
        intent.reduce(action)
    }
    
    public subscript<PropertyType>(dynamicMember keyPath: KeyPath<Model, PropertyType>) -> PropertyType {
        return model[keyPath: keyPath]
    }
}
#endif
