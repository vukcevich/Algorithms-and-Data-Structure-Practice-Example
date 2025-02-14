import UIKit

/**
 //  Two Sum
 //
 Given an array of integers nums and an integer target,
 
 return indices of the two numbers such that they add up to target.
 
 You may assume that each input would have exactly one solution,
 
 and you may not use the same element twice.
 You can return the answer in any order.
 
 //
 //  Example 1:
 //  Input: nums = [2, 7, 11, 15], target = 9
 //  Output: [0, 1]
 //  Explanation: Because nums[0] + nums[1] == 9, we return [0, 1]
 
 
 //  Example 2:
 //  Input: nums = [3, 2, 5, 4], target = 6
 //  Output: [1, 3]
 //
 //  Example 3:
 //  Input: nums = [3, 3], target = 6
 //  Output: [0, 1]
 */

/**
 You can solve this problem efficiently using a hash map (dictionary) to store the indices of the numbers you’ve seen so far. This approach has a time complexity of O(n) because you only need a single pass through the array.

 Swift Implementation:
 */
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var numToIndex = [Int: Int]() // Dictionary to store number -> index

    for (i, num) in nums.enumerated() {
        let compNum = target - num
        if let compIndex = numToIndex[compNum] {
            return [compIndex, i] // Return indices if complement found
        }
        numToIndex[num] = i // Store the number and its index
    }

    return [] // This case will never be reached as per the problem constraints
}

// Example usage:
print(twoSum([2, 7, 11, 15], 9)) // Output: [0, 1]
print(twoSum([3, 2, 4], 6))      // Output: [1, 2]
print(twoSum([3, 3], 6))         // Output: [0, 1]
print(twoSum([3, 2, 5, 4], 6))   // Output: [1, 3]

/*
 Explanation:
 Use a dictionary (numToIndex) to store numbers and their indices.
 Iterate through the array, calculating the complement (target - num).
 Check if the complement is in the dictionary:
 If yes, return the stored index and the current index.
 If no, store the current number with its index.
 Since the problem guarantees exactly one solution, we never need to handle cases with no solution.
 This method ensures an O(n) time complexity and O(n) space complexity, making it optimal for large inputs.
 */
