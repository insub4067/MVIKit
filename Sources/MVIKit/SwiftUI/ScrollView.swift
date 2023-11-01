//
//  ScrollView.swift
//
//
//  Created by 김인섭 on 11/1/23.
//

import SwiftUI

@available(iOS 15.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@ViewBuilder public func ScrollView(
    _ axes: Axis.Set = .vertical,
    showsIndicators: Bool = true,
    offsetChanged: @escaping (CGFloat) -> Void,
    @ViewBuilder content: () -> some View
) -> some View {
    
    ScrollView(axes, showsIndicators: showsIndicators) {
        content()
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("scrollView")).minY
                    Color.clear.preference(key: ScrollOffsetKey.self, value: minY)
                }
                .onPreferenceChange(ScrollOffsetKey.self) {
                    let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let keyWindow = scene?.windows.filter { $0.isKeyWindow }.first
                    let safeArea = keyWindow?.safeAreaInsets ?? .zero
                    offsetChanged($0 - safeArea.top)
                }
            }
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = nextValue() }
}
