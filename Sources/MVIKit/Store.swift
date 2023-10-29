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
public final class Store<Intent: Intentable>: ObservableObject {
    
    @Published public var model: Intent.Model
    public let intent: Intent
    
    private var cancellable = Set<AnyCancellable>()
    
    public init(
        with intent: Intent,
        modelBuilder: (Intent.Type) -> Intent.Model
    ) {
        self.intent = intent
        self.model = modelBuilder(Intent.self)
        self.intent.model = self.model
        
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
    
    public subscript<PropertyType>(dynamicMember keyPath: KeyPath<Intent.Model, PropertyType>) -> PropertyType {
        return model[keyPath: keyPath]
    }
}
#endif
