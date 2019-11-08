//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var authManager = FirebaseAuthenticationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        authManager.delegate = self
    }
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            if email.isEmpty {
                    authManager.authenticateUser(withEmail: "1@2.com", password: "123456")
            }else{
                    authManager.authenticateUser(withEmail: email, password: password)
            }
            
        }
    }
    
}

extension LoginViewController : AuthenticationManagerDelegate {
    func didFailWithError(error: Error) {
        let alert = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func didUserLoggedIn(_ registerManager: AuthenticationManager, user: UserModel?) {
        print("User logged in successfuly")
        performSegue(withIdentifier: K.loginSegue, sender: self)
    }
    
}
