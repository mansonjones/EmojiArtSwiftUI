//
//  Grid.swift
//  EmojiArtSwiftUI
//
//  Created by Manson Jones on 11/6/20.
//

import SwiftUI

extension Grid where Item: Identifiable, ID == Item.ID {
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.init(items, id: \Item.id, viewForItem: viewForItem)
    }
}
struct Grid<Item, ID, ItemView>: View where ID: Hashable, ItemView: View {
    private var items: [Item]
    private var id: KeyPath<Item, ID>
    private var viewForItem: (Item) -> ItemView
    
    
    // @escaping is used to designate a function that is called later.
    
    init(_ items: [Item], id: KeyPath<Item, ID>, viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.id = id
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(for: GridLayout(itemCount: items.count, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        return ForEach(items, id: id) { item in
            body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(where: { item[keyPath: id] == $0[keyPath: id] })
        return Group {
            if index != nil {
                viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index!))
            }
        }
    }
}

/*
 extension Array where Element: Identifiable {
 func firstIndex(matching: Element) -> Int {
 for index in 0..<self.count {
 if self[index].id == matching.id {
 return index
 }
 }
 return 0
 }
 }
 */

// TODO: Add support for this
/*
 struct Grid_Previews: PreviewProvider {
 static var previews: some View {
 Grid()
 }
 }
 */

