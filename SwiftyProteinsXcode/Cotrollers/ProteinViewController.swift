//
//  ProteinViewController.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 12/25/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit
import SceneKit

class ProteinViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var nameLbl: UILabel!
    var ligandModel = Ligand()
    var atom3dModel = Atom3DModel()
    
    // Geometry
    var geometryNode = SCNNode()
    let scene = SCNScene()
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = ligandModel.name
        
        //Parse and set array of atoms
        ligandModel.atoms = [Atom]()
        ligandModel.connections = [[Int]]()
        ligandModel.parseAtomAndConnections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupScene()
        
        geometryNode = atom3dModel.addAtoms(ligandModel.atoms)
//        geometryNode.enumerateChildNodes { (node, stop) in
//            node.removeFromParentNode()
//        }
        for arrayConect in ligandModel.connections {
            print(arrayConect)
            for atom in ligandModel.atoms {
                if atom.id == arrayConect[0] {
                    let firstAtom = atom
                    for conect in arrayConect {
                        if conect != firstAtom.id {
                            for second in ligandModel.atoms {
                                if conect == second.id {
                                    let secondAtom = second
                                    geometryNode.addChildNode(atom3dModel.addConnections(from: firstAtom, to: secondAtom))
                                }
                            }
                        }
                    }
                }
            }
        }
        
        sceneView.scene?.rootNode.addChildNode(geometryNode)
    }
    
    func setupScene() {
        
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene = scene
        
    }
    
}

