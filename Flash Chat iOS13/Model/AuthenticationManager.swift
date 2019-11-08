//
//  RegisterManager.swift
//  Flash Chat iOS13
//
//  Created by Vinicius Santana on 14/06/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation

protocol AuthenticationManager {
    var delegate : AuthenticationManagerDelegate? { get set }
    func createUser(withEmail email: String, password: String)
    func authenticateUser(withEmail email: String, password: String)
    func logOut()
    func getLoggedUser() -> String?
}

protocol AuthenticationManagerDelegate : AuthDelegate {
    func didCreateUser(_ registerManager : AuthenticationManager, user:UserModel?)
    func didUserLoggedIn(_ registerManager : AuthenticationManager, user:UserModel?)
    func didFailWithError(error: Error)
}

extension AuthenticationManagerDelegate {
    func didCreateUser(_ registerManager : AuthenticationManager, user:UserModel?){
        
    }
    func didUserLoggedIn(_ registerManager : AuthenticationManager, user:UserModel?){
        
    }
    
}
