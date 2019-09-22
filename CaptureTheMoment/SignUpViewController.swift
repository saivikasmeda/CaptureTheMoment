//
//  SignUpViewController.swift
//  CaptureTheMoment
//
//  Created by Developer on 9/22/19.
//  Copyright © 2019 vikaspractice. All rights reserved.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController,UITextFieldDelegate {

    var alertControllerObjc:UIAlertController?
    var homeNavigationControllerObj : UINavigationController?
    
    @IBOutlet weak var userNameOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var confirmPasswordOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordOutlet.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        passwordOutlet.text = ""
        userNameOutlet.text = ""
        confirmPasswordOutlet.text = ""
    }
    
    
    @IBAction func registerAction(_ sender: UIButton) {
        
        if !userNameOutlet.text!.isEmpty && !passwordOutlet.text!.isEmpty && (passwordOutlet.text == confirmPasswordOutlet.text) {
        Auth.auth().createUser(withEmail: userNameOutlet.text!, password: passwordOutlet.text!){ authResult, error in
        
            if error != nil{
                 let action = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                self.alertAction(title: "error", message: error!.localizedDescription, alertActions: [action], style: UIAlertController.Style.alert)
                return
            }

//            let action = UIAlertAction(title: "Login", style: UIAlertAction.Style.cancel){ loginobj in
//                self.homeNavigationControllerObj = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeNavi") as! UINavigationController)
//                self.present(self.homeNavigationControllerObj!, animated: true, completion: nil)
//
//            }
            let action = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: { obj in
                Auth.auth().currentUser?.sendEmailVerification{errorverify in
                print("verification error ", errorverify)
                }
            })
            self.alertAction(title: "Verify", message: "verifcation link has be sent to your email id", alertActions: [action], style: UIAlertController.Style.alert)
            }
        }
        else{
            let action = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertAction(title: "Register Error", message: "Username or password cannot be empty", alertActions: [action], style: UIAlertController.Style.alert)
            }
        
    
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let password = passwordOutlet.text {
       
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
            if !passwordTest.evaluate(with: password){
                let action = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { obj in
                    self.passwordOutlet.text = ""
                    self.confirmPasswordOutlet.text = ""
                })
                alertAction(title: "Password format", message: "should contain atleast upper lower and number & spl character", alertActions: [action], style: UIAlertController.Style.alert)

            }
        }
        
    }
    
    
    
    func alertAction(title :String, message:String ,alertActions:[UIAlertAction] , style:UIAlertController.Style){
        alertControllerObjc = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for i in alertActions{
            alertControllerObjc?.addAction(i)
        }
        self.present(alertControllerObjc!, animated: true, completion: nil)
        
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordOutlet.resignFirstResponder()
        confirmPasswordOutlet.resignFirstResponder()
        userNameOutlet.resignFirstResponder()
    }

}
