import UIKit


//MARK: Found very nice concise option:
//https://codereview.stackexchange.com/questions/173803/counting-neighbor-cells-of-a-matrix
// let sampleGrid = [[0,1,0], [0,0,0], [1,0,0]]
let sampleGridB = [[0,1,0,0], [0,0,0,1], [1,0,0,1],[0,1,0,1]]

func printMatrix(_ m:[[Any]])
{
    print(
        m.map {
            $0.map {
                "\($0)"
            }
            .joined(separator:" ")
        }
        .joined(separator:"\n")
    )
}

func addArrays  (_ A:[Int], _ B:[Int] ) -> [Int] {
    return zip(A,B).map(+)
}

func addMatrices(_ A:[[Int]], _ B:[[Int]] ) -> [[Int]] {
    return zip(A,B).map(addArrays)
}

let emptyLine   : [[Int]] = [Array(repeating:0, count:sampleGridB.count)]

let clock = ContinuousClock()
let elapsed = clock.measure {

let left        : [[Int]] = sampleGridB.map{ [0] + $0.dropLast()  } // O(n)
let right       : [[Int]] = sampleGridB.map{ $0.dropFirst() + [0] } // O(n)
let leftRight   : [[Int]] = addMatrices(left,right)                // O(n^2)
    
let up          : [[Int]] = emptyLine + sampleGridB.dropLast()      // O(n)
let down        : [[Int]] = sampleGridB.dropFirst() + emptyLine     // O(n)
let upDown      : [[Int]] = addMatrices(up,down)                   // O(n^2)

let cornersUp   : [[Int]] = emptyLine + leftRight.dropLast()       // O(n)
let cornersDown : [[Int]] = leftRight.dropFirst() + emptyLine      // O(n)

let sides       : [[Int]] = addMatrices(leftRight,upDown)          // O(n^2)
let corners     : [[Int]] = addMatrices(cornersUp,cornersDown)     // O(n^2)
// 6 x O(n) + 5 x O(n^2) ==> O(n^2)
let  neighbourCounts = addMatrices(sides,corners)         // O(n^2)

print("SampleGrid:")
printMatrix(sampleGridB)
print("\nNeighbour counts:")
printMatrix(neighbourCounts)
    
}
print("\nTime taken by the function invocation: \(elapsed)")
