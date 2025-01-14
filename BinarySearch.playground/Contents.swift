import UIKit



//https://github.com/kodecocodes/swift-algorithm-club/tree/master/Binary%20Search

/*
 
 !!!! Note that the numbers array is sorted.
 -> The binary search algorithm does not work otherwise!!!!!!
 
 Note: One thing to be aware of is that range.upperBound always points one beyond the last element.
 
 In the example, the range is 0..<19 because there are 19 numbers in the array, and so range.lowerBound = 0 and range.upperBound = 19.
 
 But in our array the last element is at index 18, not 19, since we start counting from 0.
 
 Just keep this in mind when working with ranges: the upperBound is always one more than the index of the last element.
 */

func binarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        // If we get here, then the search key is not present in the array.
        return nil
    } else {
        // Calculate where to split the array.
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        
        // Is the search key in the left half?
        if a[midIndex] > key {
            return binarySearch(a, key: key, range: range.lowerBound ..< midIndex)
    
        // Is the search key in the right half?
        } else if a[midIndex] < key {
           return binarySearch(a, key: key, range: midIndex + 1 ..< range.upperBound)
            
        // If we get here, then we've found the search key!
        } else {
            return midIndex
        }
    }
}

let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]

binarySearch(numbers, key: 43, range: 0 ..< numbers.count)  // gives 13
//binarySearch(numbers, key: 11, range: 0 ..< numbers.count)  // gives 4



/*
 Iterative vs recursive

 Binary search is recursive in nature because you apply the same logic over and over again to smaller and smaller subarrays. However, that does not mean you must implement binarySearch() as a recursive function. It's often more efficient to convert a recursive algorithm into an iterative version, using a simple loop instead of lots of recursive function calls.
 */

func binarySearch2<T: Comparable>(_ a: [T], key: T) -> Int? {
    var lowerBound = 0
    var upperBound = a.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2
        
        if a[midIndex] == key {
            return midIndex
            
        } else if a[midIndex] < key {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    return nil
}

//Iterative
let numbers2 = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
binarySearch2(numbers2, key: 43)  // gives 13


/*
 The END:
 Is it a problem that the array must be sorted first?
 
 It depends.
 
 Keep in mind that sorting takes time -- the combination of binary search plus sorting may be slower than doing a simple linear search.
 
 Binary search shines in situations where you sort just once and then do many searches.
 
 */
