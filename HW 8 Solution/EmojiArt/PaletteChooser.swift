//
//  PaletteChooser.swift
//  EmojiArt
//
//  Created by Student on 10/22/20.
//

import SwiftUI

struct PaletteChooser: View {
    
    @ObservedObject var document: EmojiArtDocument
    
    @Binding var chosenPalette: String
    
    var body: some View {
        HStack {
            Stepper(
                onIncrement: {
                    chosenPalette = document.palette(after: chosenPalette)
                },
                onDecrement: {
                    chosenPalette = document.palette(before: chosenPalette)
                },
                label: { EmptyView() }
            )
            Text(chosenPalette)
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct PaletteChooser_Previews: PreviewProvider {
    static var previews: some View {
        PaletteChooser(document: EmojiArtDocument(), chosenPalette: Binding.constant("Default Palette"))
    }
}
