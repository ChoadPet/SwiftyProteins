//
//  ProteinViewController.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 12/25/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

enum Pattern: String {
    case id = "\\d{1,3}"
    case coordinate = "-?\\d{1,3}[.]\\d{3}"
    case name = "\\w+$"
    case conections = "\\d+"
}

class ProteinViewController: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    var ligandModel = Ligand()
    var pdbInfo = [String]()
    var atom = Atom()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = ligandModel.name
        if let info = ligandModel.PDBInfo {
            pdbInfo = ligandModel.removeSpaces(info)
        }
        
        for line in pdbInfo {
//            print(line)
            if line.range(of: "ATOM") != nil {
                if let id = ligandModel.parsePDB(with: Pattern.id.rawValue, forLine: line, atIndex: 0) {
                    atom.id = Int(id)!
                }
                if let name = ligandModel.parsePDB(with: Pattern.name.rawValue, forLine: line, atIndex: 0) {
                    atom.name = name
                }
                if let x = ligandModel.parsePDB(with: Pattern.coordinate.rawValue, forLine: line, atIndex: 0) {
                    atom.coordinates.x = Float(x)!
                }
                if let y = ligandModel.parsePDB(with: Pattern.coordinate.rawValue, forLine: line, atIndex: 1) {
                    atom.coordinates.y = Float(y)!
                }
                if let z = ligandModel.parsePDB(with: Pattern.coordinate.rawValue, forLine: line, atIndex: 2) {
                    atom.coordinates.z = Float(z)!
                }
                ligandModel.atoms.append(atom)
            } else if line.range(of: "CONECT") != nil {
                
                for atom in ligandModel.atoms {
                    
                }
            }
        }
        
        
        
    }
    
    
}

