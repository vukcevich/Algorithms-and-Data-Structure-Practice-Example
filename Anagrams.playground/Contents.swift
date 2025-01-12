import UIKit

var str = "Hello, playground"

//Reference:
//https://stackoverflow.com/questions/32209803/swift-anagram-checker

/* Given a list of strings, return a list of lists of strings that groups all anagrams.
 
 Ex. given ["god", "bike", "cars", "arcs", "dog"]
 return [[cars, arcs], [bike], [dog, god]]
 */

let ar = ["god", "bike", "cars", "arcs", "dog"]

let clock0 = ContinuousClock()
let elapsed0 = clock0.measure {
    
//MARK: Variant 0:
func anagramCheck(a: String, b: String) -> Bool {
    guard a.count == b.count else { return false }
    return a.sorted() == b.sorted()
}

var result = [[String]]()
for i in 0..<ar.count {
    for j in i+1..<ar.count {
        if (anagramCheck(a: ar[i], b: ar[j])) {
            result.append([ar[i], ar[j]])
            
        } else {
            if !result.isEmpty && !result.joined().contains(ar[i])  {
                result.append([ar[i]])
            }
        }
    }
}

print("Option - 1- result1:", result)
}
print("\nTime taken by the function invocation: \(elapsed0)")


//MARK: Variant 1: Sorting of Character
// Measured time: 30.46 s
func anagramCheck1(a: String, b: String) -> Bool {
    return a.sorted() == b.sorted()
}


let clock1 = ContinuousClock()
let elapsed1 = clock1.measure {
    
//MARK: Variant 2: NSCountedSet of Character
    func anagramCheck2(a: String, b: String) -> Bool {
        guard a.count == b.count else { return false }
        let aSet = NSCountedSet()
        let bSet = NSCountedSet()
        for c in a {
            aSet.add(c)
        }
        for c in b {
            bSet.add(c)
        }
        return aSet == bSet
    }
    
    var result2 = [[String]]()
    for i in 0..<ar.count {
        for j in i+1..<ar.count {
            var tempAr = [String]()
            if (anagramCheck2(a: ar[i], b: ar[j])) {
                tempAr.append(ar[i])
                tempAr.append(ar[j])
                result2.append(tempAr)
            } else {
                if !result2.isEmpty && !result2.joined().contains(ar[i])  {
                    //Note:
                    tempAr.append(ar[i])
                    result2.append(tempAr)
                }
            }
        }
    }
    
    print("Option - 2- result2:", result2)
}
print("\nTime taken by the function invocation: \(elapsed1)")
    
let clock = ContinuousClock()
let elapsed = clock.measure {

//MARK:  Variant 3: NSCountedSet of unichar
func anagramCheck3(a: String, b: String) -> Bool {
    let aString = a as NSString
    let bString = b as NSString
    let length = aString.length
    guard length == bString.length else { return false }
    let aSet = NSCountedSet()
    let bSet = NSCountedSet()
    for i in 0..<length {
        aSet.add(aString.character(at: i))
        bSet.add(bString.character(at: i))
    }
    return aSet == bSet
}

var result3 = [[String]]()
for i in 0..<ar.count {
    for j in i+1..<ar.count {
        var tempAr = [String]()
        if (anagramCheck3(a: ar[i], b: ar[j])) {
            tempAr.append(ar[i])
            tempAr.append(ar[j])
            result3.append(tempAr)
        } else {
            if !result3.isEmpty && !result3.joined().contains(ar[i])  {
                tempAr.append(ar[i])
                result3.append(tempAr)
            }
        }
    }
}

print("Option - 3- result3:", result3)

}
print("\nTime taken by the function invocation: \(elapsed)")


