//
//  PaletteChooser.swift
//  EmojiArtSwiftUI
//
//  Created by Manson Jones on 11/5/20.
//

import SwiftUI

struct PaletteChooser: View {
    // The document is the view model
    @ObservedObject var document: EmojiArtDocument
    
    @Binding var choosenPalette: String
    @State private var showPaletteEditor = false
    
    var body: some View {
        HStack {
            Stepper(onIncrement: {
                self.choosenPalette = self.document.palette(after: self.choosenPalette)
            }, onDecrement: {
                self.choosenPalette = self.document.palette(before: self.choosenPalette)
                
            }, label: { EmptyView() })
            Text(self.document.paletteNames[self.choosenPalette] ?? "")
            Image(systemName: "keyboard")
                .imageScale(.large)
                .onTapGesture {
                    self.showPaletteEditor = true
                }
                .popover(isPresented: $showPaletteEditor) {
                    PaletteEditor(chosenPalette: $choosenPalette, isShowing: $showPaletteEditor)
                        .environmentObject(self.document)
                        .frame(minWidth: 300, minHeight: 500)
                }
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

// @EnvironmentObject is used whenever you want to use a view model
//
struct PaletteEditor : View {
    @EnvironmentObject var document: EmojiArtDocument
    
    @Binding var chosenPalette: String
    @Binding var isShowing: Bool
    @State private var paletteName: String = ""
    @State private var emojisToAdd: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
            Text("Palette Editor").font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: {
                        self.isShowing = false
                    }, label: { Text("Done")}).padding()
                }
            }
            Divider()
            Form {
                Section {
                    TextField("Palette Name", text: $paletteName, onEditingChanged: { began in
                        if !began {
                            self.document.renamePalette(self.chosenPalette, to: self.paletteName)
                        }
                    })
                    TextField("Add Emoji", text: $emojisToAdd, onEditingChanged: { began in
                        if !began {
                            self.chosenPalette = self.document.addEmoji(self.emojisToAdd, toPalette: self.chosenPalette)
                            self.emojisToAdd = ""
                        }
                    })
                }
                Section(header: Text("Remove Emoji")) {
                        Grid(chosenPalette.map { String($0) }, id: \.self) { emoji in
                            Text(emoji).font(Font.system(size: self.fontSize))
                                .onTapGesture {
                                    self.chosenPalette = self.document.removeEmoji(emoji, fromPalette: self.chosenPalette)
                                }
                        }
                        .frame(height: self.height)
                    }
            }
        }
        .onAppear { self.paletteName = self.document.paletteNames[self.chosenPalette] ?? "" }
        }
    
    // MARK: Drawing Constants
    
    var height: CGFloat {
        CGFloat((chosenPalette.count - 1) / 6) * 70 + 70
    }
    
    let fontSize: CGFloat = 40
}

struct PaletteChooser_Preview: PreviewProvider {
    static var previews: some View {
        PaletteChooser(document: EmojiArtDocument(), choosenPalette: Binding.constant(""))
    }
}
