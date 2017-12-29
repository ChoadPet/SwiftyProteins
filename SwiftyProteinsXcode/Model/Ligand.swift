//
//  Ligand.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 12/26/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import Foundation


/*
 FOR ATOM NUMBER - ATOM\s\d{1,3}\s
 FOR ATOM CONNECTION - CONECT\s\d{1,3}\s
 
 
 */

struct Coordinate {
    var x = 0.0
    var y = 0.0
    var z = 0.0
}

class Ligand {
    var PDBInfo: String?
    var name: String?
    
    //Info about element or atom or whatever
    var atomID = Int()
    var atomConnection = [Int]()
    var atomName = String()
    var atomCcoordinates = Coordinate()
    
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
        
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: line, options: [], range: NSRange(location: 0, length: line.characters.count))
        let resultMatch = matches.map({ (line) in
            newLine.substring(with: line.range)
        })
        if !resultMatch.isEmpty {
            result = resultMatch[index]
        }
        return result
    }
    
}
