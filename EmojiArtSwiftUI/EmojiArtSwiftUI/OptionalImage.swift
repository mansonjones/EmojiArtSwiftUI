//
//  File.swift
//  EmojiArtSwiftUI
//
//  Created by Manson Jones on 11/2/20.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
}
