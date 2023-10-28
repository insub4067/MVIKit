//
//  Viewable.swift
//
//
//  Created by 김인섭 on 10/28/23.
//

#if canImport(SwiftUI)
import SwiftUI

public protocol Viewable: View {
    
    associatedtype Model: Modelable
    associatedtype Intent: Intentable
    
    var container: Container<Model, Intent> { get }
}

public extension Viewable {
    
    var model: Model { container.model }
    var intent: Intent { container.intent }
}

#endif
