//
//  ContentView.swift
//  Shared
//
//  Created by Student on 9/4/20.
//

import SwiftUI

struct ContentView: View {
    @State var fib_num: String = ""
    @State var fac_num: String = ""
    @State var sum_num1: String = ""
    @State var sum_num2: String = ""
    @State var coin_num: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("HW 1").font(.title).fontWeight(.bold).padding(.top, -100).padding(.leading, 25).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
           
            Group {
                Text("Fibonacci sequence").fontWeight(.bold).padding().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                HStack {
                    TextField("Input fibonacci sequence number", text: $fib_num).padding(.leading, 25)
                    Text(compute_fibonacci(fib_num_amount: Int(fib_num) ?? 0)).padding(.trailing, 100)
                }
            }

            Group {
                Text("Factorial number").fontWeight(.bold).padding().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                HStack {
                    TextField("Input factorial number", text: $fac_num).padding(.leading, 25)
                    Text(compute_factorial(fac_num_amount: Int(fac_num) ?? 0)).padding(.trailing, 100)
                }
            }

            Group {
                Text("Sum of all integers in range").fontWeight(.bold).padding().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                HStack {
                    TextField("Input begginning range", text: $sum_num1).padding(.leading, 25)
                    Text(compute_sum_of_all_integers(first_num: Int(sum_num1) ?? 0, second_num: Int(sum_num2) ?? 0)).padding(.trailing, 100)
                }
                TextField("Input ending range", text: $sum_num2).padding(.leading, 25)
            }

            Group {
                Text("Least amount of coins").fontWeight(.bold).padding().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                HStack {
                    TextField("Input coin amount", text: $coin_num).padding(.leading, 25)
                    Text(compute_coins_for_amount(amount: Int(coin_num) ?? 0)).padding(.trailing, 100)
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


