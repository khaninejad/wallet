//
//  UserLoginViewModel.swift
//  wallet
//
//  Created by Payam on 5/6/21.
//

import Foundation

class UserLoginViewModel : ObservableObject {
    
    @Published var loginState : Bool = false

    
    func login() {
        if (validate()){
            loginState = true
        }else {
            loginState = false
        }
        
       
    }

    
    func validate() -> Bool {
        
        return false
        
    }
}
