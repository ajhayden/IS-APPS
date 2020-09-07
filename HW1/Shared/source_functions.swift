//
//  source_functions.swift
//  HW1
//
//  Created by Aaron Hayden on 9/6/20.
//

import Foundation

// Calculate the fibonacci sequence number
func compute_fibonacci(fib_num_amount: Int) -> String {
    guard fib_num_amount > 1 else {return String(fib_num_amount)}
    var first_num = 0
    var second_num = 1
    
    for _ in 1...fib_num_amount {
        let temp = second_num
        second_num = first_num + second_num
        first_num = temp
    }
    
    return String(second_num)
}

// Calculate the factorial of a given number >= 0
func compute_factorial(fac_num_amount: Int) -> String {
    var output = 1
    if(fac_num_amount == 0) {
        return "0"
    }
    for n in 1...fac_num_amount {
        output *= n
    }
    return String(output)
}

// Calculate the sum of all integers between two given integers
func compute_sum_of_all_integers(first_num: Int, second_num: Int) -> String {
    var sum = 0
    if(first_num == second_num) {
        return String(first_num)
    }
    //Flip around first and second number depending on higher number
    if(first_num > second_num) {
        for n in second_num...first_num {
            sum += n
        }
    }
    if(second_num > first_num) {
        for n in first_num...second_num {
            sum += n
        }
    }
    
    return String(sum)
}

//Calculates the least amount of specific coins to hit a target amount
func compute_coins_for_amount(amount: Int) -> String {
    var total_quarters = 0
    var total_dimes = 0
    var total_nickels = 0
    var total_pennies = 0
    
    var quarter_str = "quarters"
    var dime_str = "dimes"
    var nickel_str = "nickels"
    var penny_str = "pennies"

    var current_total = amount
    
    while current_total >= 25 {
        current_total -= 25
        total_quarters += 1
    }

    while current_total >= 10 {
        current_total -= 10
        total_dimes += 1
    }

    while current_total >= 5 {
        current_total -= 5
        total_nickels += 1
    }

    while current_total >= 1 {
        current_total -= 1
        total_pennies += 1
    }
    
    var total_quarters_str = String(total_quarters)
    var total_dimes_str = String(total_dimes)
    var total_nickels_str = String(total_nickels)
    var total_pennies_str = String(total_pennies)
    
    if(total_quarters == 1) {
        quarter_str = "quarter"
    }
    
    if(total_quarters == 0) {
        quarter_str = ""
        total_quarters_str = ""
    }
    
    if(total_dimes == 1) {
        dime_str = "dime"
    }
    
    if(total_dimes == 0) {
        dime_str = ""
        total_dimes_str = ""
    }

    if(total_nickels == 1) {
        nickel_str = "nickel"
    }
    
    if(total_nickels == 0) {
        nickel_str = ""
        total_nickels_str = ""
    }

    if(total_pennies == 1) {
        penny_str = "penny"
    }
    
    if(total_pennies == 0) {
        penny_str = ""
        total_pennies_str = ""
    }
    
    var output = ""
    
    if(total_quarters >= 1) {
        output = "\(total_quarters_str) \(quarter_str)"
    }
    if(total_dimes >= 1) {
        output += "\n\(total_dimes_str) \(dime_str)"
    }
    if(total_nickels >= 1) {
        output += "\n\(total_nickels_str) \(nickel_str)"
    }
    if(total_pennies >= 1) {
        output += "\n\(total_pennies_str) \(penny_str)"
    }
    
    if(output == "") {
        output = "No coins"
    }

    print(output) //Required to print the console from HW2 assignment
    return output
}
