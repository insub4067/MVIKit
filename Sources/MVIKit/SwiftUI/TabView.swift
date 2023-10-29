//
//  TabView.swift
//
//
//  Created by 김인섭 on 10/29/23.
//

import SwiftUI

@available(iOS 15.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@ViewBuilder public func TabView<Value: Hashable>(
    selection: Binding<Value>,
    tabChanged: @escaping (Value) -> Void,
    @ViewBuilder content: () -> some View
) -> some View {
    TabView(selection: selection, content: content)
        .onChange(of: selection.wrappedValue, perform: { value in
            tabChanged(value)
        })
}
