import UIKit


var intArray = [71, 60, 30, 50, 80, 99, 50, 40]

func getMaxDifference(arr:[Int]) -> Int {
   // let len = arr.count
    var max = 0
    var min = 0
    var result = 0
    
    //for  i in 0..<len {
    for  i in 0..<arr.count {
        
        if(arr[i] > max) {
            max = arr[i]
        }
        
        if(i == 0) {
            min = arr[i]
        } else {
            if(arr[i] < min) {
                min = arr[i]
            }
        }
        
        
    }
    print("max: \(max)")
    print("min: \(min)")
    result = max - min
    
    return result
}

var maxDif = getMaxDifference(arr: intArray)

print("max difference:", maxDif)


