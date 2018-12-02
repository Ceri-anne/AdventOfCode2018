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



