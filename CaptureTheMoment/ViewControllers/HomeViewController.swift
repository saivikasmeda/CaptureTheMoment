//
//  HomeViewController.swift
//  CaptureTheMoment
//
//  Created by Developer on 9/22/19.
//  Copyright © 2019 vikaspractice. All rights reserved.
//

import UIKit
import Firebase
class HomeViewController: UIViewController {

    @IBOutlet weak var userNameOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutAction(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            dismiss(animated: true, completion: nil)
        }catch let signOutError as NSError{
            print("Error signing Out ", signOutError.localizedDescription)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
