//
//  Ligand.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 12/26/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import Foundation

struct Coordinate {
    var x = 0.0
    var y = 0.0
    var z = 0.0
}

class Ligand {
    var PDBInfo: String?
    var CIFInfo: String?
    var id: String?
    var type: String?
    var name: String?
    var formula: String?
    var weight: Float?
    
    var coordinates = Coordinate()
}
