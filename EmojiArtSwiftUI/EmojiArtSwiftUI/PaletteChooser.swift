//
//  PaletteChooser.swift
//  EmojiArtSwiftUI
//
//  Created by Manson Jones on 11/5/20.
//

import SwiftUI

struct PaletteChooser: View {
    @ObservedObject var document: EmojiArtDocument
    
    @Binding var choosenPalette: String
    
    var body: some View {
        HStack {
            Stepper(onIncrement: {
                self.choosenPalette = self.document.palette(after: self.choosenPalette)
            }, onDecrement: {
                self.choosenPalette = self.document.palette(before: self.choosenPalette)
                
            }, label: { EmptyView() })
            Text(self.document.paletteNames[self.choosenPalette] ?? "")
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct PaletteChooser_Preview: PreviewProvider {
    static var previews: some View {
        PaletteChooser(document: EmojiArtDocument(), choosenPalette: Binding.constant(""))
    }
}
