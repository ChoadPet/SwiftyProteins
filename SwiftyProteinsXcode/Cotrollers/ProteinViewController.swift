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
    @IBOutlet weak var atomNameLbl: UILabel!
    
    var ligandModel = Ligand()
    var atom3dModel = Atom3DModel()
    
    // Geometry
    var atomNodes = SCNNode()
    var connectionNodes = SCNNode()
    let mainScene = SCNScene()
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder() // To get shake gesture
        
        nameLbl.text = ligandModel.name
        
        //Parse and set array of atoms
        ligandModel.atoms = [Atom]()
        ligandModel.connections = [[Int]]()
        ligandModel.parseAtomAndConnections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupScene()
        
        atomNodes = atom3dModel.addAtoms(ligandModel.atoms, isSquare: false)
        connectionAlgorithm()
        sceneView.scene?.rootNode.addChildNode(atomNodes)
        sceneView.scene?.rootNode.addChildNode(connectionNodes)
    }
    
    // MARK: - functions
    
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Why are you shaking me?")
        }
    }
    
    func connectionAlgorithm() {
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
                                    connectionNodes.addChildNode(atom3dModel.addConnections(from: firstAtom, to: secondAtom))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setupScene() {
        
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene = mainScene
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 35)
        mainScene.rootNode.addChildNode(cameraNode)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProteinViewController.handleTab(recognize:)))
        sceneView.addGestureRecognizer(tap)
        
    }
    
    // MARK: - IBActions
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        atomNodes.removeFromParentNode()
        connectionNodes.removeFromParentNode()
        
        switch sender.selectedSegmentIndex {
        case 0:
            atomNodes = atom3dModel.addAtoms(ligandModel.atoms, isSquare: false)
            connectionAlgorithm()
        case 1:
            atomNodes = atom3dModel.addAtoms(ligandModel.atoms, isSquare: true)
            connectionAlgorithm()
        default:
            break
        }
        sceneView.scene?.rootNode.addChildNode(atomNodes)
        sceneView.scene?.rootNode.addChildNode(connectionNodes)
    }
    
    // MARK: - GestureRecognizers

    @objc func handleTab(recognize: UITapGestureRecognizer) {
        if recognize.state == .ended {
            let location = recognize.location(in: sceneView)
            let hits = self.sceneView.hitTest(location, options: nil)
            if !hits.isEmpty {
                if let tappedNode = hits.first?.node {
                    for atom in ligandModel.atoms {
                        if atom.coordinates.x == tappedNode.position.x {
                            if atom.coordinates.y == tappedNode.position.y {
                                atomNameLbl.text = atom.name
                            }
                        }
                    }
                }
            }
        }
    }
    
}






















