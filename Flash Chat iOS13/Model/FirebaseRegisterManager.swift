//
//  FirebaseRegisterManager.swift
//  Flash Chat iOS13
//
//  Created by Vinicius Santana on 14/06/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseAuthenticationManager : RegisterManager {
    var delegate: RegisterManagerDelegate?
    
    
    func createUser(withEmail email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.delegate?.didFailWithError(error: e)
            } else {
                self.delegate?.didCreateUser(self, user: UserModel())
            }
        }
    }
    
}
