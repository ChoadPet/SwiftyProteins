//
//  Atom3DModel.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 1/6/18.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import Foundation
import SceneKit

final class Atom3DModel {

    //MARK: - Private API
    class func myAtom(withColor color: UIColor) -> SCNGeometry {
        let atom = SCNSphere(radius: 1.50)
        
        atom.firstMaterial?.diffuse.contents = color
        atom.firstMaterial?.specular.contents = UIColor.white
        
        return atom
    }
    
    //MARK: - Public API
    class func addAtomToNode(_ atoms: [Atom]) -> SCNNode {
        let node = SCNNode()
        
        for atom in atoms {
            nodeWithAtom(atom: myAtom(withColor: UIColor.darkGray), molecule: node, position:
                SCNVector3(atom.coordinates.x, atom.coordinates.y, atom.coordinates.z))
        }
        
        return node
    }
    
    class func nodeWithAtom(atom: SCNGeometry, molecule: SCNNode, position: SCNVector3) {
        let node = SCNNode(geometry: atom)
        node.position = position
        molecule.addChildNode(node)
    }
    
}
