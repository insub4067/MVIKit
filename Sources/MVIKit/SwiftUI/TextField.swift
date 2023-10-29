//
//  File.swift
//  
//
//  Created by 김인섭 on 10/29/23.
//

import SwiftUI

@available(iOS 15.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@ViewBuilder public func TextField(
    text: Binding<String>,
    textChanged: @escaping (String) -> Void,
    label: @escaping () -> some View
) -> some View {
    TextField(text: text, label: label)
        .onChange(of: text.wrappedValue, perform: { value in
            textChanged(value)
        })
}
