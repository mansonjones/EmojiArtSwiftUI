//
//  EmojiArtDocument.swift
//  EmojiArtSwiftUI
//
//  Created by Manson Jones on 10/29/20.
//

// This is the ViewModel of the M-VM-V design pattern

import SwiftUI

class EmojiArtDocument: ObservableObject {
    static let palette: String = "⭐️☁️🍎🌍🥨⚾️"
    
    @Published private var emojiArt: EmojiArt = EmojiArt() {
        didSet {
            // print("json = \(emojiArt.json?.utf8 ?? "nil")")
            UserDefaults.standard.set(emojiArt.json, forKey: "EmojiArtDocument.Untitled")
        }
    }
    
    private static let untitled = "EmojiArtDocument.untitled"
    
    init() {
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: EmojiArtDocument.untitled)) ?? EmojiArt()
        fetchBackgroundImageData()
    }
    // UIImage is a holdover from Objective C
    @Published private(set) var backgroundImage: UIImage?
    
    var emojis: [EmojiArt.Emoji] { emojiArt.emojis }
    
    // MARK: - Intent(s)
    
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }
    
    func setBackgroundURL(_ url: URL?) {
        emojiArt.backgroundURL = url?.imageURL
        fetchBackgroundImageData()
    }
    
    private func fetchBackgroundImageData() {
        // TODO: Add a spinner while the fetch is in progress
        backgroundImage = nil
        /*
         if let url = self.emojiArt.backgroundURL {
         let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
         guard let data = data else {
         return
         }
         DispatchQueue.main.async {
         self.backgroundImage = UIImage(data: data)
         }
         }
         task.resume()
         */
        
        // TODO: Convert this to use URLSession
        // The following implementation is very basic
        
        if let url = self.emojiArt.backgroundURL {
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        if url == self.emojiArt.backgroundURL {
                            self.backgroundImage = UIImage(data: imageData)
                        }
                    }
                }
                
            }
        }
        
    }
    
}

extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}
