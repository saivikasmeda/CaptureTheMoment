//
//  ViewController.swift
//  CaptureTheMoment
//
//  Created by Developer on 9/22/19.
//  Copyright © 2019 vikaspractice. All rights reserved.
//

import UIKit
import Firebase
class SignInController: UIViewController {
    var homeNavigationControllerObj :UINavigationController?
    var alertControllerObjc :UIAlertController?
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil{
            print("user is logged in")
        }
        print(Auth.auth().currentUser?.isEmailVerified)
        let backButton = UIBarButtonItem(title: "SignIn", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        passwordOutlet.text = ""
        usernameOutlet.text = ""
    }

    @IBAction func signInAction(_ sender: UIButton) {
        if !usernameOutlet.text!.isEmpty && !passwordOutlet.text!.isEmpty{
            Auth.auth().signIn(withEmail: usernameOutlet.text!, password: passwordOutlet.text!) { [weak self] user, error in
                guard self != nil else { return }
                if error != nil{
                    print("error ", error?.localizedDescription)
                    let action = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel){ actionObj in
                        self!.passwordOutlet.text = ""
                        
                    }
                    self!.alertAction(title: "Invalid Credentails", message: "Check Username or password", alertActions: [action], style: UIAlertController.Style.alert)
                    return
                }
                let userSignedIn = Auth.auth().currentUser
          
                let action = UIAlertAction(title: "Login", style: UIAlertAction.Style.cancel){ loginobj in
                    self!.homeNavigationControllerObj = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeNavi") as! UINavigationController)
                    let root =  self!.homeNavigationControllerObj?.viewControllers.first as! HomeViewController
                    root.loadView()
                    root.userNameOutlet.text = userSignedIn?.displayName
                    root.userNameOutlet.sizeToFit()
                    self?.present(self!.homeNavigationControllerObj!, animated: true, completion: nil)
                }
                self!.alertAction(title: "Success", message: "Account has been Created", alertActions: [action], style: UIAlertController.Style.alert)

                
                }
            }
        else{
            let action = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel){ actionObj in
                self.passwordOutlet.text = ""
                
            }
            alertAction(title: "Error", message: "Username or password cannot be empty", alertActions: [action], style: UIAlertController.Style.alert)
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
        usernameOutlet.resignFirstResponder()
        passwordOutlet.resignFirstResponder()
    }
    @IBAction func forgetPasswordAction(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: usernameOutlet.text!){ error in
            print("error in reset password ",error)
        }
 
    }
}

