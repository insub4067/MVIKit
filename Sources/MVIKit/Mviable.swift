//
//  Mviable.swift
//
//
//  Created by 김인섭 on 10/28/23.
//

#if canImport(SwiftUI)
import SwiftUI

public protocol Mviable: View {
    
    associatedtype Model: Modelable
    associatedtype Intent: Intentable
    
    var store: Store<Model, Intent> { get }
}

public extension Mviable {
    
    var model: Model { store.model }
    var intent: Intent { store.intent }
}
#endif
