//
//  EmojiArtDocumentView.swift
//  EmojiArtSwiftUI
//
//  Created by Manson Jones on 10/29/20.
//

import SwiftUI

// EmojiArtDocumentView is the View of the M-VM-V design pattern

struct EmojiArtDocumentView: View {
    
    // EmojiArtDocument is the ViewModel in the M-VM-V design patten
    @ObservedObject var document: EmojiArtDocument
    
    // In the example below, \.self is a keypath
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(EmojiArtDocument.palette.map { String($0) }, id: \.self ) { emoji in
                    Text(emoji)
                        .font(Font.system(size: defaultEmojiSize))
                }
            }
        }
    }
    
    private let defaultEmojiSize: CGFloat = 40
}

/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */
