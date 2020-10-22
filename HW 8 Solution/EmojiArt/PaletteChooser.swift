//
//  PaletteChooser.swift
//  EmojiArt
//
//  Created by Student on 10/22/20.
//

import SwiftUI

struct PaletteChooser: View {
    var body: some View {
        HStack {
            Stepper(
                onIncrement: { },
                onDecrement: { },
                label: { EmptyView() }
            )
            Text("Palette Name")
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct PaletteChooser_Previews: PreviewProvider {
    static var previews: some View {
        PaletteChooser()
    }
}
