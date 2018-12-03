import Foundation

let fileUrl = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try! String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
let inputArray = input.components(separatedBy: CharacterSet.newlines)

var doublesTotal = 0
var triplesTotal = 0

for string in inputArray {

    var doubles = 0
    var triples = 0

    for c in string {
        let n = string.filter { $0 == c }.count
        if n == 2 {
            doubles += 1
        } else if n == 3 {
            triples += 1
        }
    }

    if doubles > 0 {
        doublesTotal += 1
    }

    if triples > 0 {
        triplesTotal += 1
    }
}

let part1 = doublesCount * triplesCount
print(part1)


func checkOneDifferent(_ string1: String, _ string2: String) -> Bool {
    guard string1.count == string2.count else {
        return false
    }
    
    var count = 0
    
    for i in 0..<string1.count {
        if Array(string1)[i] != Array(string2)[i] {
            count += 1
        }
        if count > 1 {
            return false
        }
    }
    
    return count == 1

}

func findOneDifferent(from array: [String]) -> [String] {

    var resultArray = [String]()
    
    for i in 0..<array.count {
        
        for j in 0..<array.count {
            
            if j != i && checkOneDifferent(array[i],array[j]) == true {
                resultArray.append(array[i])
            }
        }

    }
    return resultArray
}


let oneDifferent = findOneDifferent(from: inputArray)

func findMatchingString(_ string1: String, _ string2: String) -> String {
   
    var result = ""
    for i in 0..<string1.count {
        if Array(string1)[i] == Array(string2)[i] {
            result.append(Array(string1)[i])
        }
    }
    
    return result
    
}

let part2 = findMatchingString(oneDifferent[0], oneDifferent[1])
print(part2)
