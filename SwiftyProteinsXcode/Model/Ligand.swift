
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

enum Pattern: String {
    case id = "\\d{1,3}"
    case coordinate = "-?\\d{1,3}[.]\\d{3}"
    case name = "\\w+$"
    case conections = "\\d+"
}

struct Coordinate {
    var x: Float = 0.0
    var y: Float = 0.0
    var z: Float = 0.0
}

struct Atom {
    var id = Int()
    var name = String()
    var coordinates = Coordinate()
}

final class Ligand {
    var PDBInfo: String?
    var name: String?
    var atoms = [Atom]()
    var connections = [[Int]]()
    
    //MARK: - Public interface
    
    public func parseAtomAndConnections() {
        var pdbInfo = [String]()
        var atom = Atom()
        
        if let info = PDBInfo {
            pdbInfo = removeSpaces(info)
        }
        for line in pdbInfo {
            if line.range(of: "ATOM") != nil {
                atom.id = Int(parsePDB(with: Pattern.id.rawValue, forLine: line, atIndex: 0))!
                atom.name = parsePDB(with: Pattern.name.rawValue, forLine: line, atIndex: 0)
                atom.coordinates.x = Float(parsePDB(with: Pattern.coordinate.rawValue, forLine: line, atIndex: 0))!
                atom.coordinates.y = Float(parsePDB(with: Pattern.coordinate.rawValue, forLine: line, atIndex: 1))!
                atom.coordinates.z = Float(parsePDB(with: Pattern.coordinate.rawValue, forLine: line, atIndex: 2))!
                atoms.append(atom)
            } else if line.range(of: "CONECT") != nil {
                setupConnections(with: Pattern.conections.rawValue, forLine: line)
            }
        }
        //        for atom in atoms {
        //            print("Atom id: \(atom.id)\nAtom name: \(atom.name)\nAtom coordinates:\tx: [\(atom.coordinates.x)]\ty: [\(atom.coordinates.y)]\tz: [\(atom.coordinates.z)]\n")
        //        }
    }
    
    //MARK: - Private interface
    
    private func removeSpaces(_ str: String) -> [String] {
        let str = str
            .components(separatedBy: " ")
            .filter { !$0.isEmpty }
            .joined(separator: " ")
        
        let array = str.components(separatedBy: .newlines)
        return array
    }
    
    private func parsePDB(with pattern: String, forLine line: String, atIndex index: Int) -> String {
        var result = String()
        let newLine = line as NSString
        
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let matches = regex.matches(in: line, range: NSRange(location: 0, length: line.count))
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
    
    private func setupConnections(with regex: String, forLine line: String) {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let matches = regex.matches(in: line, range: NSRange(line.startIndex..., in: line))
            self.connections.append(matches.map { Int(line[Range($0.range, in: line)!])! })
        } catch let error {
            print("error: \(error.localizedDescription)")
        }
    }
    
}
