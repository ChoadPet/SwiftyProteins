//
//  Atom3DModel.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 1/6/18.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

final class Atom3DModel {
    
    let colors = ["C": UIColor.cpkLightGray(),
                  "O": UIColor.cpkRed(),
                  "H": UIColor.cpkWhite(),
                  "N": UIColor.cpkLightBlue(),
                  "S": UIColor.cpkYellow(),
                  "PH": UIColor.cpkOrange(),
                  "I": UIColor.cpkOrange(),
                  "CH": UIColor.cpkGreen(),
                  "BR": UIColor.cpkBrown(),
                  "Z": UIColor.cpkBrown(),
                  "CA": UIColor.cpkDarkGrey(),
                  "MA" : UIColor.cpkDarkGreen(),
                  "Other": UIColor.cpkPink()]
    
    //MARK: - Public API
    public func addAtoms(_ atoms: [Atom]) -> SCNNode {
        let atomNode = SCNNode()
        
        for atom in atoms {
            nodeWithAtom(atom: myAtom(atom.name), molecule: atomNode, position:
                SCNVector3(atom.coordinates.x, atom.coordinates.y, atom.coordinates.z))
        }
        return atomNode
    }
    
    public func addConnections(from firstAtom: Atom, to secondAtom: Atom) -> CylinderLine {
        let connectionNode = SCNNode()
        let cylinder = CylinderLine(parent: connectionNode, v1: SCNVector3(firstAtom.coordinates.x, firstAtom.coordinates.y, firstAtom.coordinates.z), v2:
            SCNVector3(secondAtom.coordinates.x, secondAtom.coordinates.y, secondAtom.coordinates.z), r: 0.1, segmentCount: 150, color: UIColor.cpkLightGray())
        return cylinder
        
    }
    
    //MARK: - Private API
    
    private func nodeWithAtom(atom: SCNGeometry, molecule: SCNNode, position: SCNVector3) {
        let node = SCNNode(geometry: atom)
        node.position = position
        molecule.addChildNode(node)
    }
    
    private func myAtom(_ name: String) -> SCNGeometry {
        let atom = SCNSphere(radius: 0.25)
        
        atom.firstMaterial?.diffuse.contents = colors[name] ?? colors["Other"]
        atom.firstMaterial?.specular.contents = UIColor.white
        return atom
    }
    
}

extension UIColor {
    class func cpkLightGray() -> UIColor {
        return UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0)
    }
    class func cpkRed() -> UIColor {
        return UIColor(red:0.94, green:0.00, blue:0.00, alpha:1.0)
    }
    class func cpkWhite() -> UIColor {
        return UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    }
    class func cpkLightBlue() -> UIColor {
        return UIColor(red:0.56, green:0.56, blue:1.00, alpha:1.0)
    }
    class func cpkYellow() -> UIColor {
        return UIColor(red:1.00, green:0.78, blue:0.20, alpha:1.0)
    }
    class func cpkOrange() -> UIColor {
        return UIColor(red:1.00, green:0.65, blue:0.00, alpha:1.0)
    }
    class func cpkGreen() -> UIColor {
        return UIColor(red:0.00, green:1.00, blue:0.00, alpha:1.0)
    }
    
    class func cpkBrown() -> UIColor {
        return UIColor(red:0.65, green:0.16, blue:0.16, alpha:1.0)
    }
    
    class func cpkBlue() -> UIColor {
        return UIColor(red:0.00, green:0.00, blue:1.00, alpha:1.0)
    }
    class func cpkPink() -> UIColor {
        return UIColor(red:1.00, green:0.08, blue:0.58, alpha:1.0)
    }
    class func cpkDarkGrey() -> UIColor {
        return UIColor(red:0.50, green:0.50, blue:0.50, alpha:1.0)
    }
    class func cpkDarkGreen() -> UIColor {
        return UIColor(red:0.16, green:0.50, blue:0.16, alpha:1.0)
    }
}

extension SCNGeometry {
    class func lineFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> SCNGeometry {
        let indices: [Int32] = [0, 1]
        
        let source = SCNGeometrySource(vertices: [vector1, vector2])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        
        return SCNGeometry(sources: [source], elements: [element])
        
    }
    
}











