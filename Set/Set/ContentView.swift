//
//  ContentView.swift
//  Set
//
//  Created by Student on 9/24/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    // Use angles to have things come off screen
    
    var body: some View {
        GeometryReader { geometry in
            LazyVGrid(columns: [GridItem(.flexible())]) {
                ForEach(viewModel.cards) { _ in
                    //                    SquiggleView()
                    Text("Item N \(geometry.size.width) \(geometry.size.height)")
                        .padding()
                        .foregroundColor(.blue)
                        .transition(AnyTransition.offset(
                            randomLocationOffScreen(for: geometry.size)
                        ))
                }
            }
            .onAppear {
                withAnimation() {
                    for i in 0..<20 {
                        let delay = Double(i) * 0.5
                        withAnimation(Animation.easeInOut.delay(delay)) {
                            viewModel.dealCard()
                        }
                    }
                }
            }
        }
    }
    
    func randomLocationOffScreen(for size: CGSize) -> CGSize {
        var randomSize = CGSize.zero
        let randomAngle = Double.random(in: 0..<Double.pi * 2)
        let scaleFactor = max(size.width, size.height) * 1.5
        
        randomSize.width = CGFloat(sin(randomAngle)) * scaleFactor
        randomSize.height = CGFloat(cos(randomAngle)) * scaleFactor
        
        return randomSize
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
