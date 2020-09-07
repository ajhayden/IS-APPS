//
//  ContentView.swift
//  Shared
//
//  Created by Student on 9/4/20.
//

import SwiftUI

struct ContentView: View {
    @State var fib_num: String = "1"
    @State var fac_num: String = "1"
    @State var sum_num1: String = "1"
    @State var sum_num2: String = "2"
    @State var coin_num: String = "1"
    
    var body: some View {
        VStack {
            Text("HW 1").padding()
           
            Group {
                Text("Fibonacci sequence")
                TextField("Fibonacci sequence", text: $fib_num)
                Text(compute_fibonacci(fib_num_amount: Int(fib_num) ?? 0))
            }
            
            Group {
                Text("Factorial number")
                TextField("Factorial number", text: $fac_num)
                Text(compute_factorial(fac_num_amount: Int(fac_num) ?? 0))
            }

            Group {
                Text("Sum of all integers between two numbers")
                TextField("Number 1", text: $sum_num1)
                TextField("Number 2", text: $sum_num2)
                Text(compute_sum_of_all_integers(first_num: Int(sum_num1) ?? 0, second_num: Int(sum_num2) ?? 0))
            }

            Group {
                Text("Least amount of coins")
                TextField("Fibonacci sequence", text: $coin_num)
                Text(compute_coins_for_amount(amount: Int(coin_num) ?? 0))
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


