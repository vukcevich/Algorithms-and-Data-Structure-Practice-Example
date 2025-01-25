import UIKit

var greeting = "Hello, playground"

let coins = [1, 5, 10, 25]
let amount = 98 //105

//MARK: My fun example/solution:
func coinChangeWithDetails(_ coins: [Int], _ amount: Int) -> ([Int: Int]) {
    
    var coinCounts: [Int: Int] = [:]
    
    let t25x = amount / coins[3]
    let t25 = amount % coins[3]
    if t25x != 0 {
        coinCounts[coins[3]] = t25x
    }
    if t25 != 0 {
        let t10x = t25 / coins[2]
        let t10 = t25 % coins[2]
        if t10x != 0 {
            coinCounts[coins[2]] = t10x
        }
        if t10 != 0 {
            let t5x = t10 / coins[1]
            let t5 = t10 % coins[1]
            if t5x != 0 {
                coinCounts[coins[1]] = t5x
            }
            if t5 != 0 {
                let t1x = t5 / coins[0]
                let t1 = t5 % coins[0]
                if t1x != 0 {
                    coinCounts[coins[0]] = t1x
                }
            }
        }
    }
    return coinCounts
}

let cc = coinChangeWithDetails(coins, amount)
print("my result-cc:", cc)
/*
 ChatGPT explanation:
 Your implementation performs a greedy algorithm for the coin change problem, which is straightforward and efficient in cases where the coin denominations allow it to work optimally (e.g., denominations like [1, 5, 10, 25]). However, it may not work for all scenarios where denominations do not form a canonical coin system.
 */

func coinChangeWithDetails2(_ coins: [Int], _ amount: Int) -> [Int: Int] {
    var remainingAmount = amount
    var coinCounts: [Int: Int] = [:]
    // Iterate through each coin in descending order
    for coin in coins.sorted(by: >) {
        if remainingAmount >= coin {
            let count = remainingAmount / coin
            coinCounts[coin] = count
            remainingAmount %= coin
        }
    }
    
    return coinCounts
}

//Example usage:
let coins2 = [1, 5, 10, 25]
let amount2 = 87

let result2 = coinChangeWithDetails2(coins2, amount2)
print("2-Coins used: \(result2)")

/*
 Explanation of Changes:
 Dynamic Iteration:
 Instead of hard-coding the indices (coins[3], coins[2], etc.), the code now loops through the sorted array of coins in descending order.
 Remaining Amount:
 The variable remainingAmount is reduced by taking the modulus (%) of the coin value after each calculation.
 Handling Arbitrary Coin Sets:
 This version works for any set of coin denominations, as long as they are provided in the input.
 */
