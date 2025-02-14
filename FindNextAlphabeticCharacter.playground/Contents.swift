import UIKit

/**
 You are given two strings s and t of the same length.
 Your task is to check whether for each i, t[i] is the next alphabetic character of s[i], considering the alphabet is cyclic ('a' goes after 'z').
 Return true if the condition satisfies, and false otherwise.
 For example, 'b' is the next character of 'a', and 'a' is the next character of 'z'. However, 's' is not the next character of 't', as well as 'w' is not the next character of 'u', and 'z' is not the next character of 'a'.
 */

/*
 You can solve this problem in Swift by iterating through the characters of both strings and checking whether each character in t is the next alphabetic character of the corresponding character in s. Given that the alphabet is cyclic, the condition to check is:

 t[i]=next character of s[i]
 
 which can be rewritten in ASCII terms as:
 
 t[i]=Character((s[i].asciiValue!−96)%26+97)
 
 Here’s the Swift implementation:
 */

func isNextAlphabeticCyclic(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }
    
    let sArray = Array(s)
    let tArray = Array(t)
    
    for i in 0..<sArray.count {
        let expectedNextChar = Character(UnicodeScalar((sArray[i].asciiValue! - 96) % 26 + 97))
        if tArray[i] != expectedNextChar {
            return false
        }
    }
    
    return true
}

// Example cases
print(isNextAlphabeticCyclic("abc", "bcd")) // true
print(isNextAlphabeticCyclic("abc", "abd")) // false
print(isNextAlphabeticCyclic("xyz", "yza")) // true
print(isNextAlphabeticCyclic("stu", "vwx")) // false
print(isNextAlphabeticCyclic("zzz", "aaa")) // true
print(isNextAlphabeticCyclic("hello", "ifmmp")) // true
print(isNextAlphabeticCyclic("swift", "txjgu")) // true


/*
 Explanation:
 Convert the string to an array for easy indexing.
 Iterate through each character and compute its expected next character using ASCII manipulation.
 If any character in t does not match the expected one, return false.
 If all characters satisfy the condition, return true.
 This solution runs in O(n) time, where n is the length of the strings.
 */
