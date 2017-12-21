//
//  ViewController.swift
//  SwiftyProteinsXcode
//
//  Created by Vitalii Poltavets on 12/17/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignBackground()
        loginField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
        passwordField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func assignBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "backgroundProteins")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
}

