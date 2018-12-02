import Foundation

let fileUrl = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try! String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
let array = input.components(separatedBy: CharacterSet.newlines)

func numbers(from input: String) -> [Int] {
    let array = input.components(separatedBy: CharacterSet.newlines)
    return array.compactMap{ Int($0) }
}

let arrayNumbers = numbers(from: input)

let part1 = arrayNumbers.reduce(0, +)
print(part1)


var sum = 0
var frequencies = Set<Int>()

func frequencyCheck() -> Int {
    for i in 0..<arrayNumbers.count {
        sum += arrayNumbers[i]
        if frequencies.contains(sum) {
            return sum
        } else {
            frequencies.insert(sum)
        }
    }
   return frequencyCheck()
}

let part2 = frequencyCheck()
print(part2)

