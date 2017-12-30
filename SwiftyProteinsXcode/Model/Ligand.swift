
import Foundation

enum Type: String {
    case H = "white"
    case C = "black"
    case N = "dark blue"
    case O = "red"
    case BR = "dark red"
    case FE = "dark orange"
    case I = "dark voilet"
    case P = "orange"
    case S = "yellow"
    case B = "salmon"
    case TI = "gray"
    case F, CL = "green"
    case HE, NE, AR, XE, KR = "cyan"
    case BE, MG, CA, SR, BA, RA = "dark green"
    
    case Other = "pink"
}

struct Coordinate {
    var x: Float = 0.0
    var y: Float = 0.0
    var z: Float = 0.0
}

struct Atom {
    //Info about element or atom or whatever
    var id = Int()
    var name = String()
    var coordinates = Coordinate()
    var connection = [Int]()
}

class Ligand {
    var PDBInfo: String?
    var name: String?
    
    //Info about element or atom or whatever
    var atoms = [Atom]()
    
    func removeSpaces(_ str: String) -> [String] {
        let str = str
            .components(separatedBy: " ")
            .filter { !$0.isEmpty }
            .joined(separator: " ")
        
        let array = str.components(separatedBy: .newlines)
        return array
    }
    
    func parsePDB(with pattern: String, forLine line: String, atIndex index: Int) -> String? {
        var result: String?
        let newLine = line as NSString
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: line, options: [], range: NSRange(location: 0, length: line.count))
            let resultMatch = matches.map({ (line) in
                newLine.substring(with: line.range)
            })
            if !resultMatch.isEmpty {
                result = resultMatch[index]
            }
            return result
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return "error"
        }
    }
    
}
