//
//  ViewController.swift
//  SwiftyProteinsXcode
//
//  Created by Vitalii Poltavets on 12/17/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet var loadingView: UIView!
    @IBOutlet weak var touchButton: UIButton!
    @IBOutlet weak var squareForFields: UIView!
    
    //Appears if device doesn't support Touch ID
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = LAContext()
        
        showLoadingView()
        hiddingLoadingScreen()
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            squareForFields.isHidden = true
            touchButton.setImage(UIImage(named: "fingerprint"), for: .normal)
        } else {
            touchButton.isHidden = true
        }
    }
    
    func showLoadingView() {
        loadingView.bounds.size.width = view.bounds.width
        loadingView.bounds.size.height = view.bounds.height
        loadingView.center = view.center
        view.addSubview(loadingView)
    }
    
    func hiddingLoadingScreen() {
        UIView.animate(withDuration: 2.5) {
            self.loadingView.transform = CGAffineTransform(scaleX: 2, y: 2)
            UIView.animate(withDuration: 1) {
                self.loadingView.transform = CGAffineTransform(translationX: 0, y: -800)
            }
        }
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        performSegue(withIdentifier: "listOfView", sender: self)
    }
    @IBAction func touchAction(_ sender: UIButton) {
        touchIDCall()
    }
    
    func touchIDCall() {
        let authContex = LAContext()
        authContex.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Need your fucking finger", reply: { (success, error) in
            if success {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "listOfView", sender: self)
                }
            } else {
                print("Another finger please!")
            }
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
}

