//: Playground - noun: a place where people can play

import UIKit

//Coding Test  --- Swift 

//Find sequence in integers in an array of integers 
//input: 5,6,7,8
//output: "5-8"
//input: 2,5,6,7,8,10,14,17,18,25
//output: "2","5-8","10","14","17-18","25"


//let ar = [1,2,3,5,6,7,8,12,21,34,35,44,45,46,47,48]
//let ar = [5,6,7,8]
let ar = [2,5,6,7,8,10,14,17,18,25]

print("Find sequence in array:")
print("Input: ", ar)

//MARK: My solution (breaking it down manually), did not check what's run time for this
var output = ""
//Check if it's sequence or not
var seq = false
var k = 0 //count variable -- to compare for last, 'continue' skips

for (i, value) in ar.enumerated() {
    // print(i, value) //first check
    
    k = i //count variable -- to compare for last
    
    //populate first
    if (i == 0 ) {
        output += "\(ar[i])"
    }
    
    //check if not last
    if (i < ar.count - 1) {
        
        //difference between current and next should be 1 if it's a sequence,
        //otherwise, append
        let diffValue = ar[i + 1] - value
        
        if (diffValue == 1) {
            seq = true //set to true - it's sequence
            k += 1 //update count, due to 'continue'
            
            //Skip last index so we can capture it and add to result
            if ( k != ar.endIndex - 1) {
                continue
            }
        }
        
        //check if sequence is true
        if (seq) {
            //last value in index needs to be added
            if(k == ar.endIndex - 1) {
                output += "-\(ar[k])"
            } else {
                output += "-\(ar[i])"
            }
        }
        
        //start new sequnce if v value larger then 1
        if (diffValue >= 2) {
            output += ","
            output += "\(ar[i + 1])"
            seq = false
        }
    }
    
}
print("Final-output:", output)


//in: Sequence_grouping.playground
//Another approach:
//let ar1 = [1,2,3,4,10,11,15,20,21,22,23,27]
let ar1 = [2,5,6,7,8,10,14,17,18,25]
let indexSet1 = IndexSet(ar1)
let rangeView1 = indexSet1.rangeView
//Note: It seems the .map call here is not needed, so I commented it.
let newNumAr = rangeView1
//    .map {
//        Array($0.indices)
//    }
    .reduce(into: []) { result, elem in
        result.append(
            elem.map {
                String($0)
            }
            .joined(separator: "-")
        )
    }
    .map{ String($0) }.joined(separator: ",")
print("result-1:", newNumAr)
//result-1: 1-2-3-4,10-11,15,20-21-22-23,27



//MARK: Found this interesting extension for Character Stridable
// it allows you to use for loop from range of Characters
extension Character: @retroactive Strideable {

    public func distance(to other: Character) -> Int {
        let selfValue = self.unicodeScalars.first?.value ?? 0
        let otherValue = other.unicodeScalars.first?.value ?? 0
        return Int(otherValue - selfValue)
    }

    public func advanced(by n: Int) -> Character {
        guard let scalar = self.unicodeScalars.first else {
            fatalError("Cannot advance an empty character")
        }
        
        guard self.unicodeScalars.count == 1 else {
            fatalError("❌ Cannot advance when a character is made by combined code points. This is a limitation of Swift.")
        }
        
        let newValue = Int(scalar.value) + n
        guard let newScalar = Unicode.Scalar(newValue) else {
            fatalError("Resulting scalar value is invalid")
        }
        return Character(newScalar)
    }
}


let a: Character = "a"
let z: Character = "z"

let alphabeticalRange = a...z
print(alphabeticalRange.count) // 26
for letter in alphabeticalRange {
    print(letter) // prints a to z...
}



//Swift Copilot - solution
class CopilotSolution {
    
    func findSequence() {
        let ar = [2, 5, 6, 7, 8, 10, 14, 17, 18, 25]
        //let ar = [1,2,3,5,6,7,8,12,21,34,35,44,45,46,47,48]
        //let ar = [5,6,7,8]

        print("Find sequence in array:")
        print("Input: ", ar)

        var output: [String] = [] // To store the result strings
        var start = ar[0] // Start of the current sequence
        var end = start  // End of the current sequence

        for i in 1..<ar.count {
            if ar[i] == end + 1 {
                // Continue the sequence
                end = ar[i]
            } else {
                // Sequence breaks, append the range or single number to output
                if start == end {
                    output.append("\(start)")
                } else {
                    output.append("\(start)-\(end)")
                }
                // Start a new sequence
                start = ar[i]
                end = start
            }
        }

        // Handle the last sequence
        if start == end {
            output.append("\(start)")
        } else {
            output.append("\(start)-\(end)")
        }

        print("Final-output:", output.joined(separator: ","))
    }
}

CopilotSolution().findSequence()

/*
 Complexity:
 Time Complexity: O(n), where n is the length of the array.
 Space Complexity: O(n), for the output array.
 This approach is cleaner, more efficient, and handles edge cases effectively.
 */
