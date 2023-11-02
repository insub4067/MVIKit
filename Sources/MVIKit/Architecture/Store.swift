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
public final class Store<Reducer: Reduceable>: ObservableObject {
    
    @Published public var model: Reducer.Model
    private let reducer: Reducer
    
    private var cancellable = Set<AnyCancellable>()
    
    public init(
        with reducer: Reducer,
        modelBuilder: () -> Reducer.Model
    ) {
        self.reducer = reducer
        self.model = modelBuilder()
        self.reducer.model = self.model
        
        model.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellable)
    }
    
    public func send(_ action: Reducer.Action) {
        reducer.reduce(action)
    }
    
    public subscript<PropertyType>(dynamicMember keyPath: KeyPath<Reducer.Model, PropertyType>) -> PropertyType {
        return model[keyPath: keyPath]
    }
}
#endif
