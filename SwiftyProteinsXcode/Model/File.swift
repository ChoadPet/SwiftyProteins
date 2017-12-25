//
//  File.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 12/25/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import Foundation

struct File {
    
    let fileName = "ligands"
    let type = "txt"
    var ligands = [String]()
    
    mutating func readFrom() {
        if let path = Bundle.main.path(forResource: fileName, ofType: type) {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                ligands = data.components(separatedBy: .newlines)
            } catch {
                print(error)
            }
        }
    }
}
