
/*
 
 Write a Swift playground that takes an n x n grid of integers. Each integer can be either 1 or 0.
 
 The playground then outputs an n x n grid where each block indicates the number of 1's around that block, (excluding the block itself) . For Block 0 on row 0, surrounding blocks are (0,1) (1,0) and (1,1). Similary for block (1,1) all the blocks around it are to be counted as surrounding blocks.
 
 Requirements:
 
 Make sure your solution works for any size grid.
 Spend an hour and a half coding the logic and another hour cleaning your code (adding comments,  cleaning variable and function names).
 
 Optimize your functions to be O(n^2).
 
 Your output lines should not have any trailing or leading whitespaces.
 
 Please use hard coded example input constants below.
 
 Examples:
 
 1) Input Grid:
 
 let sampleGrid = [[0,1,0], [0,0,0], [1,0,0]]
 
 Console Output:
 
 1 0 1
 2 2 1
 0 1 0
 
 //-----------------
 
 2) Input Grid:
 
 let sampleGrid = [[0,1,0,0], [0,0,0,1], [1,0,0,1], [0,1,0,1]]
 
 Console Output:
 
 1 0 2 1
 2 2 3 1
 1 2 4 2
 2 1 3 1
 
 */


import UIKit

//Use it for display: 
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


//I solved it by manually looping through grid data....
//MARK: Check simpler version -> SampleGid_CodeReview.playground
class SampleGrid {
    
    let gridData:[[Int]]

    init(data: [[Int]]) {
        self.gridData = data
        createNewGrid(gridData: self.gridData)
    }
    
    func createNewGrid(gridData:[[Int]]) {
        
        var updatedGrid: [[Int]] = []
        for x in 0..<gridData.count {
            updatedGrid.append([Int]())
            for y in 0..<gridData[x].count {
                let newValue = updateValueForPosition(row: x, col: y, data: gridData, rowLen: gridData.count, colLen: gridData[0].count)
                updatedGrid[x].append(newValue)
            }
        }
        
       // print("Output: \(updatedGrid)")
        print("Neighbour Count:")
        printMatrix(updatedGrid)
    }
    
    func updateValueForPosition(row: Int, col: Int, data: [[Int]], rowLen: Int, colLen: Int) -> Int {
        
        let rowBefore = data.index(before: row)
        let rowAfter = data.index(after: row)
        let colBefore = data[row].index(before: col)
        let colAfter = data[row].index(after: col)
        
        var totalValue = 0
        
        if (rowBefore == -1) {
            //Handle first row - only
            
            //same for First Row - all columns
            if( data[rowAfter][col] == 1 ) {
                totalValue += 1
            }
            
            if (colBefore == -1) {
                //First Row - handle first col
                
                if( data[row][colAfter] == 1 ) {
                    totalValue += 1
                }
                if( data[rowAfter][colAfter] == 1 ) {
                    totalValue += 1
                }
                
            } else if (colAfter == colLen) {
                //First Row - handle last col
                
                if(data[row][colBefore] == 1 ) {
                    totalValue += 1
                }
                if(data[rowAfter][colBefore] == 1 ) {
                    totalValue += 1
                }
                
            } else {
                //For larger NxN grids - First Row
                if(data[row][colBefore] == 1  ) {
                    totalValue += 1
                }
                if(data[row][colAfter] == 1 ) {
                    totalValue += 1
                }
                if(data[rowAfter][colBefore] == 1  ) {
                    totalValue += 1
                }
                if(data[rowAfter][colAfter] == 1 ) {
                    totalValue += 1
                }
                
            }
            
        } else if (rowAfter == rowLen) {
            //Handle Last Row")
            
            //same for all columns - Last Row
            if( data[rowBefore][col] == 1 ) {
                totalValue += 1
            }
            
            if (colBefore == -1) {
                //Last Row - handle first col")
                if( data[row][colAfter] == 1 ) {
                    totalValue += 1
                }
                if( data[rowBefore][colAfter] == 1 ) {
                    totalValue += 1
                }
                
            } else if (colAfter == colLen) {
                //Last Row - handle last col")
                if(data[row][colBefore] == 1 ) {
                    totalValue += 1
                }
                if(data[rowBefore][colBefore] == 1 ) {
                    totalValue += 1
                }
                
            } else {
                //For larger NxN Grids - Last Row
                if(data[row][colBefore] == 1  ) {
                    totalValue += 1
                }
                if(data[row][colAfter] == 1 ) {
                    totalValue += 1
                }
                if(data[rowBefore][colBefore] == 1  ) {
                    totalValue += 1
                }
                if(data[rowBefore][colAfter] == 1 ) {
                    totalValue += 1
                }
            }
            
        } else {
            //Middle Rows --- larger NxN grids - not first row and not last row
            
            //same for all middle rows
            if(data[rowBefore][col] == 1 ) {
                totalValue += 1
            }
            if(data[rowAfter][col] == 1) {
                totalValue += 1
            }
            
            if (colBefore == -1) {
                //Middle Row - handle first col
                
                //row before
                if( data[rowBefore][colAfter] == 1) {
                    totalValue += 1
                }
                
                //current row
                if( data[row][colAfter] == 1 ) {
                    totalValue += 1
                }
                
                //row after
                if (data[rowAfter][colAfter] == 1 ) {
                    totalValue += 1
                }
                
            } else if (colAfter == colLen) {
                //Middle Row - handle last col
                
                //row before
                if( data[rowBefore][colBefore] == 1) {
                    totalValue += 1
                }
                
                //current row
                if( data[row][colBefore] == 1 ) {
                    totalValue += 1
                }
                
                //row after
                if (data[rowAfter][colBefore] == 1 ) {
                    totalValue += 1
                }
                
            } else {
                // Middle Row - for larger NxN grids
                
                //row before
                if( data[rowBefore][colBefore] == 1) {
                    totalValue += 1
                }
                if( data[rowBefore][colAfter] == 1) {
                    totalValue += 1
                }
                
                //current row
                if( data[row][colBefore] == 1) {
                    totalValue += 1
                }
                if( data[row][colAfter] == 1) {
                    totalValue += 1
                }
                
                //row after
                if( data[rowAfter][colBefore] == 1) {
                    totalValue += 1
                }
                if( data[rowAfter][colAfter] == 1) {
                    totalValue += 1
                }
                
            }
            
        }
        
        return totalValue
    }
    
}

//let sampleGrid = [[0,1,0], [0,0,0], [1,0,0]]
let sampleGrid2 = [[0,1,0,0], [0,0,0,1], [1,0,0,1],[0,1,0,1]]

print("sampleGrid:")
printMatrix(sampleGrid2)
print("\n")
//var s = SampleGrid(data:sampleGrid)

let clock = ContinuousClock()
let elapsed = clock.measure {

    var s2 = SampleGrid(data:sampleGrid2)
    
}

print("\nTime taken by the function invocation: \(elapsed)")
    
    
/*
 Examples:
 Input Grid:
 let sampleGrid = [[0,1,0], [0,0,0], [1,0,0]]
 
 Console Output:
 
 1 0 1
 2 2 1
 0 1 0
 
---------
 Input Grid:
 let sampleGrid = [[0,1,0,0], [0,0,0,1], [1,0,0,1],[0,1,0,1]]
 
 Console Output:
 
 1 0 2 1
 2 2 3 1
 1 2 4 2
 2 1 3 1
 
 */




