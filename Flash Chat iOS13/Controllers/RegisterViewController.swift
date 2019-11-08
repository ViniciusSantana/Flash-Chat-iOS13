//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    var registerManager : AuthenticationManager = FirebaseAuthenticationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerManager.delegate = self
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            registerManager.createUser(withEmail: email, password: password)
        }
    }
    
}

extension RegisterViewController : AuthenticationManagerDelegate {
    
    func didCreateUser(_ registerManager: AuthenticationManager, user: UserModel?) {
        performSegue(withIdentifier: K.registerSegue, sender: self)
    }
    
    func didFailWithError(error: Error) {
        let alert = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
