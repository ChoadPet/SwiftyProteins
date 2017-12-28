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
    
    func getAtomId(inStr str: String) {
        
        let regex = try! NSRegularExpression(pattern: <#T##String#>, options: <#T##NSRegularExpression.Options#>)
    }
}
