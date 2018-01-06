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
    
    // Geometry
    var geometryNode: SCNNode = SCNNode()
    // Gestures
    var currentAngleX: Float = 0.0
    var currentAngleY: Float = 0.0
    //    var currentAngle: Float = 0.0
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = ligandModel.name
        
        //Parse and set array of atoms
        ligandModel.parseAtomAndConnections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupScene()
        geometryNode = Atom3DModel.addAtomToNode(ligandModel.atoms)
        sceneView.scene?.rootNode.addChildNode(geometryNode)
    }
    
//    func colorForAtom(withName name: String) {
//        switch Type {
//        case name == Type.H:
//        default:

//        }
//    }
    
    func setupScene() {
        let scene = SCNScene()
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor(white: 0.67, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
        
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = SCNLight.LightType.omni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 50, 50)
        scene.rootNode.addChildNode(omniLightNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 50)
        scene.rootNode.addChildNode(cameraNode)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ProteinViewController.panGesture(sender:)))
        sceneView.addGestureRecognizer(panRecognizer)
        
        // 3
        sceneView.scene = scene
    }
    
    @objc func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: sender.view!)
        
        var newAngleX = (Float)(translation.y)*(Float)(Double.pi)/180.0
        newAngleX += currentAngleX
        var newAngleY = (Float)(translation.x)*(Float)(Double.pi)/180.0
        newAngleY += currentAngleY
        
        geometryNode.eulerAngles.x = newAngleX
        geometryNode.eulerAngles.y = newAngleY
        
        if(sender.state == UIGestureRecognizerState.ended) {
            currentAngleX = newAngleX
            currentAngleY = newAngleY
        }
    }
    
//    func pinchGesture(sender: UIPinchGestureRecognizer) {
//        let zoom = sender.scale
//        var z = cameraNode.position.z  * Float(1.0 / zoom)
//        z = fmaxf(zoomLimits.min, z)
//        z = fminf(zoomLimits.max, z)
//
//        cameraNode.position.z = z
//    }
    
}

