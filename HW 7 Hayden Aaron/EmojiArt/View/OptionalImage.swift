//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by Student on 10/15/20.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        if let image = uiImage {
            Image(uiImage: image)
        }
    }
}
