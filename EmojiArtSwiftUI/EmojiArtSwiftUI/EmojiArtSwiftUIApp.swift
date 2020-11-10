//
//  EmojiArtSwiftUIApp.swift
//  EmojiArtSwiftUI
//
//  Created by Manson Jones on 10/29/20.
//

import SwiftUI

@main


struct EmojiArtSwiftUIApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            // TODO: Figure out how to get this to work.
                // let store = EmojiArtDocumentStore(named: "Emoji Art")
                // store.addDocument()
                // store.addDocument(named: "Hello world")
                // let contentView = EmojiArtDocumentChooser().environmentObject(store)
                // return contentView
            // EmojiArtDocumentChooser().environmentObject(EmojiArtDocumentStore(named: "Emoji Art"))
            EmojiArtDocumentView(document: EmojiArtDocument())
            
        }
    }
    
}
