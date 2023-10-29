//
//  Reduceable.swift
//  SwiftUIPractice
//
//  Created by 김인섭 on 10/28/23.
//

import Foundation

public protocol Reduceable: ObservableObject {
    
    associatedtype Action: Equatable
    associatedtype Model: Modelable
 
    var model: Model? { get set }
    func reduce(_ action: Action)
}
