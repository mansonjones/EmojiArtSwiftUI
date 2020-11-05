//
//  Spinning.swift
//  EmojiArtSwiftUI
//
//  Created by Manson Jones on 11/5/20.
//

import SwiftUI

struct Spinning: ViewModifier {
    // Be declaring @State, the variable is stored on the heap
    @State var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: isVisible ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear { self.isVisible = true }
        
    }
}

extension View {
    func spinning() -> some View {
        self.modifier(Spinning())
    }
}
