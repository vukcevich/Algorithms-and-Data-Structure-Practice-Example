import UIKit

var greeting = "Hello, playground"

class Solution {
    func findClosestNumber(_ nums: [Int]) -> Int {
        var closest = 0
        var minDistance = Int.max

        for i in 0..<nums.count {
            var absValue = abs(nums[i])

            if absValue < minDistance || (absValue == minDistance && absValue > closest) {
                closest = nums[i]
                minDistance = absValue
            }
        }
        return closest
    }
}

//let nums = [-4,-2,1,4,8]
let nums = [2,-1,1]

let clock = ContinuousClock()
let elapsed = clock.measure {
    
   let cl = Solution().findClosestNumber(nums)
   print("Closest number:", cl)
}

print("\nTime taken by the function invocation: \(elapsed)")

/**
 Find Closest Number to Zero - Solution Explanation

 Problem Understanding

 Given an array of integers, find the number closest to zero. If there are multiple numbers with the same closest distance, return the largest one
 (for example, if both 2 and -2 exist, return 2)

 Approach

 First, we maintain two variables:
 closestNumber: stores the number closest to zero found so far
 minDistance: stores the minimum absolute distance to zero found so far
 We iterate through the array, and for each number:
 Calculate its absolute distance from zero using Math abs()
 Update our answer if either:
 a. We found a number closer to zero (smaller than absolute value), OR
 b. We found a number equally closest but larger (same absolute value but bigger number)
 Example Walkthrough

 Input nums = [-4, 2, 1, -1]

 Step-by-step process:

 Initialize: closestNumber = 0, minDistance = Int.max
 First iteration (num = -4)
 absValue = 4
 4 < Integer.MAX_VALUE -> closestNumber = -4, minDistance = 4
 Second iteration (num = 2)
 absValue = 2
 2 < 4 -> closestNumber = -2, minDistance = 2
 Third iteration (num = 1)
 absValue = 1
 1 < 2 -> closestNumber = 1, minDistance = 1
 Fourth iteration (num = -1)
 absValue = 1
 1 = minDistance but -1 < closestNumber -> no update
 Time & Space Complexity

 Time Complexity: O(n), where n is the length of the input array
 Space Complexity: O(1), using only two variables regardless of input size
 
 Code Details

 Using 'Int.max' value as initial minDistance ensures the first number will be considered
 'Math abs()' handles both positive and negative numbers elegantly
 The condition absValue == minDistance && num > closestNumber ensures we keep the larger number when distances are equal
 */
