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
                  "CH": UIColor.cpkGreen(),
                  "BR": UIColor.cpkBrown(),
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
        
        //        for arrayConect in connection {
        //            print(arrayConect)
        //            for atom in atoms {
        //                if atom.id == arrayConect[0] {
        //                    let firstAtom = atom
        //                    for conect in arrayConect {
        //                        if conect != firstAtom.id {
        //                            for second in atoms {
        //                                if conect == second.id {
        //                                    let secondAtom = second
        let cylinder = CylinderLine(parent: connectionNode, v1: SCNVector3(firstAtom.coordinates.x, firstAtom.coordinates.y, firstAtom.coordinates.z), v2: SCNVector3(secondAtom.coordinates.x, secondAtom.coordinates.y, secondAtom.coordinates.z), r: 0.03, segmentCount: 150, color: UIColor.cpkLightGray())
        return cylinder
    
}
    
    //MARK: - Private API
    
    private func connections() {
        
    }
    
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
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    class func cpkLightGray() -> UIColor {
        return UIColor(rgb: 0x202020)
    }
    class func cpkRed() -> UIColor {
        return UIColor(rgb: 0xee2010)
    }
    class func cpkWhite() -> UIColor {
        return UIColor(rgb: 0xffffff)
    }
    class func cpkLightBlue() -> UIColor {
        return UIColor(rgb: 0x8F8FFF)
    }
    class func cpkYellow() -> UIColor {
        return UIColor(rgb: 0xFFC832)
    }
    class func cpkOrange() -> UIColor {
        return UIColor(rgb: 0xFFA500)
    }
    class func cpkGreen() -> UIColor {
        return UIColor(rgb: 0x00FF00)
    }
    
    class func cpkBrown() -> UIColor {
        return UIColor(rgb: 0xA52A2A)
    }
    
    class func cpkBlue() -> UIColor {
        return UIColor(rgb: 0x0000FF)
    }
    
    class func cpkOrangeI() -> UIColor {
        return UIColor(rgb: 0xFFA500)
    }
    class func cpkPink() -> UIColor {
        return UIColor(rgb: 0xff1493)
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











