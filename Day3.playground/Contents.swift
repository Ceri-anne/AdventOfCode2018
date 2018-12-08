import Foundation

let fileUrl = Bundle.main.url(forResource: "input", withExtension: "txt")!
let claims = try! String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
let claimsArray = claims.components(separatedBy: CharacterSet.newlines)

let xPattern = "@ ([0-9].*),"
let yPattern = ",([0-9].*):"
let widthPattern = ": ([0-9].*)x"
let heightPattern = "x([0-9].*)"

func extract(pattern: String, input: String) -> String? {
    do {
        let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        let match = regex.firstMatch(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
        
        if let match = match, let range = Range(match.range(at: 1), in: input) {
            let output = input[range]
            return String(output)
        }
    } catch {
        print("No match found")
    }
    return nil
    
}

struct Position: CustomDebugStringConvertible, Equatable, Hashable {
    let x: Int
    let y: Int
    
    var debugDescription: String {
        return "Position(x: \(x), y: \(y))"
    }
}

func startPosition(from claim: String) -> Position {
    let x = extract(pattern: xPattern, input: claim)!
    let y = extract(pattern: yPattern, input: claim)!
    return Position(x: Int(x)!, y: Int(y)!)
}

func height(from claim: String) -> Int {
    let height = extract(pattern: heightPattern, input: claim)!
    return Int(height)!
}

func width(from claim: String) -> Int {
    let width = extract(pattern: widthPattern, input: claim)!
    return Int(width)!
}

func endPosition(from claim: String) -> Position {
    let start = startPosition(from: claim)
    let x = start.x + width(from: claim) - 1
    let y = start.y + height(from: claim) - 1
    return Position(x: x, y: y)
}

func positions(from claim: String) -> Set<Position> {
    let start = startPosition(from: claim)
    let end = endPosition(from: claim)
    
    var positions = Set<Position>()
    
    for x in start.x...end.x {
        for y in start.y...end.y {
            let position = Position(x: x, y: y)
            positions.insert(position)
        }
    }
    return positions
}

func checkClaims(_ claims: [String]) -> Int {
   
    var positionsChecked = Set<Position>()
    var seenBefore = Set<Position>()
    var samePositionCount = 0
    
    for claim in claims {
        for position in positions(from: claim) {
            if positionsChecked.contains(position) {
                seenBefore.insert(position)
            } else {
                positionsChecked.insert(position)
            }
        }
    }
    return seenBefore.count
    
}


let part1 = checkClaims(claimsArray)
print(part1)

