//
//  Intentable.swift
//  SwiftUIPractice
//
//  Created by 김인섭 on 10/28/23.
//

import Foundation

public protocol Intentable: ObservableObject {
    
    associatedtype Action: Equatable
    associatedtype Model: Modelable
    
    var model: Model? { get set }
    
    func send(_ action: Action)
}
