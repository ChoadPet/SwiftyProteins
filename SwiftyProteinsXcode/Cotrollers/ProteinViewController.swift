//
//  ProteinViewController.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 12/25/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class ProteinViewController: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    var ligandModel = Ligand()
    var pdbInfo = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = ligandModel.name
        if let info = ligandModel.PDBInfo {
            pdbInfo = ligandModel.removeSpaces(info)
        }
        
        for line in pdbInfo {
            if line.range(of: "ATOM") != nil {
                let idPattern = "\\d{1,3}"
//                let xPattern =
//                let yPattern =
//                let zPattern =
//                let namePattern =
                if let id = ligandModel.parsePDB(with: idPattern, forLine: line, atIndex: 0) {
                    ligandModel.atomID = Int(id)!
                }
                print(ligandModel.atomID)
            } else if line.range(of: "CONECT") != nil {
                
                
            }
        }
        
        
        
    }
    
    
}

