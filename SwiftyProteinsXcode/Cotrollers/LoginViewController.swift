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
    @IBOutlet weak var warningLbl: UILabel!
    
    //Appears if device doesn't support Touch ID
    @IBOutlet weak var loginButton: UIButton!
    
    let request = Request(key: "7b4ed9f58d3b68edbe9c2cdbb914a36c3e7525b956e0cf7aa4c17c352aec8e46", secret: "dfbddf3ccc673a7c69e51c347045f32b847e99e9888d6c172b989bfcd637ae60")
    var device = Device()
    var file = File()
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoadingView()
        
        squareForFields.layer.cornerRadius = 10
        warningLbl.isHidden = true
        request.basicRequest()
        hiddingLoadingScreen()
        
        if device.isEnableID() {
            touchButton.setImage(UIImage(named: "fingerprint"), for: .normal)
        } else {
            touchButton.isHidden = true // Hidding button for older devices
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
        if (loginField.text?.isEmpty)! {
            warningLbl.isHidden = false
            warningLbl.text = "Empty Username field!"
        } else {
            warningLbl.isHidden = true
            print("Looking for: [\(loginField.text!)] user")
            if let token = self.request.token {
                self.request.getUser(by: token, with: loginField.text!, completion: { (response, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    if let response = response {
                        if !response.isEmpty {
                            self.file.readFrom()
                            DispatchQueue.main.async {
                                self.loginField.text = ""
                                self.passwordField.text = ""
                                self.performSegue(withIdentifier: "toLigandsTable_2", sender: self)
                            }
                        } else {
                            DispatchQueue.main.async {
                              self.displayPopup()
                            }
                        }
                    }
                })
            }
        }
        
    }
    @IBAction func touchAction(_ sender: UIButton) {
        warningLbl.isHidden = true
        file.readFrom()
        touchIDCall()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLigandsTable_1" || segue.identifier == "toLigandsTable_2" {
            if let vc = segue.destination as? LigandsTableViewController {
                vc.ligands = file.ligands
            }
        }
    }
    
    func displayPopup() {
        let alert = UIAlertController(title: "Wrong username!", message: "Type valid username for intra42.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            print("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func touchIDCall() {
        let authContex = LAContext()
        authContex.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "To Log in", reply: { (success, error) in
            if success {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toLigandsTable_1", sender: self)
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

