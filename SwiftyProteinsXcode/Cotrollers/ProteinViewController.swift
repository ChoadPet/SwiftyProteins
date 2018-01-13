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
        
        let shareButton = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(ProteinViewController.didTapedButton(sender:)))
        self.navigationItem.rightBarButtonItem = shareButton
        
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
    
    @objc func didTapedButton(sender: UIButton) {
        
        // Screenshot:
        UIGraphicsBeginImageContextWithOptions(self.sceneView.frame.size, true, 0.0)
        self.sceneView.drawHierarchy(in: self.sceneView.frame, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let img = img {
            let objectsToShare = [img] as [UIImage]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func connectionAlgorithm() {
        for arrayConect in ligandModel.connections {
//             print(arrayConect)
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

//extension UIApplication {
//
//    class var topViewController: UIViewController? {
//        return getTopViewController()
//    }
//
//    private class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let nav = base as? UINavigationController {
//            return getTopViewController(base: nav.visibleViewController)
//        }
//        if let tab = base as? UITabBarController {
//            if let selected = tab.selectedViewController {
//                return getTopViewController(base: selected)
//            }
//        }
//        if let presented = base?.presentedViewController {
//            return getTopViewController(base: presented)
//        }
//        return base
//    }
//}
//
//extension Equatable {
//    func share() {
//        let activity = UIActivityViewController(activityItems: [self], applicationActivities: nil)
//        UIApplication.topViewController?.present(activity, animated: true, completion: nil)
//    }
//}





















