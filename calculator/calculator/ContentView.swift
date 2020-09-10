//
//  ContentView.swift
//  calculator
//
//  Created by Student on 9/10/20.
//

import SwiftUI

struct ContentView: View {
    let data = ["C", "( )", "%", "/", "7", "8", "9", "*", "4", "5", "6", "-", "1", "2", "3", "+", "+/-", "0", ".", "="]
    @ObservedObject var result: calculationObj
    
    let columns = [
            GridItem(.adaptive(minimum: 80))
        ] 

    var body: some View {
        ScrollView {
            Text(result.value)
                .padding(.top, 100)
                .padding(.leading, 300)
                .font(.title)
                .foregroundColor(Color.gray)
                .font(.custom("Georgia", size: 40))
            
            HStack {
                Button(action: {
                    result.removeLastCharacter()
                }) {
                    Text("<-")
                        .foregroundColor(Color.white)
                        .frame(width: 50, height: 30)
                        .foregroundColor(Color.black)
                        .background(Color.gray)
                        .clipShape(Rectangle())
                }
            }
            .padding(.leading, 293)
            .padding(.top, 190)

            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    if item == "=" {
                        Button(action: {
                            result.calculateResult()
                        }) {
                            Text(item)
                                .foregroundColor(Color.white)
                                .frame(width: 100, height: 60)
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                    } else if (item == "C") {
                        Button(action: {
                            result.clearResult()
                        }) {
                            Text(item)
                                .foregroundColor(Color.white)
                                .frame(width: 100, height: 60)
                                .background(Color.purple)
                                .clipShape(Circle())
                        }
                    } else {
                        Button(action: {
                            result.calculateDisplay(value_str: item)
                        }) {
                            Text(item)
                                .foregroundColor(Color.white)
                                .frame(width: 100, height: 60)
                                .background(Color.purple)
                                .clipShape(Circle())
                        }
                    }
                    
                }
            }
            .padding(.horizontal)
            .padding(.top, 30)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(result: calculationObj())
    }
}
