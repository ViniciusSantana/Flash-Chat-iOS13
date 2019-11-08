//
//  FirebaseRegisterManager.swift
//  Flash Chat iOS13
//
//  Created by Vinicius Santana on 14/06/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseAuthenticationManager : AuthenticationManager {
    
    var delegate: AuthenticationManagerDelegate?
    
    
    func createUser(withEmail email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.delegate?.didFailWithError(error: e)
            } else {
                self.delegate?.didCreateUser(self, user: UserModel())
            }
        }
    }
    
    func authenticateUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let e = error {
                self.delegate?.didFailWithError(error: e)
            } else {
                self.delegate?.didUserLoggedIn(self, user: UserModel())
            }
        }
    }
    
    func logOut() {
        do{
            try Auth.auth().signOut()
        } catch {
            print("Error sigining out: %@",error)
            
        }
    }
    
    func getLoggedUser() -> String? {
        return Auth.auth().currentUser?.email
    }
    
    
}
