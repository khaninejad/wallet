//
//  UserLoginViewModel.swift
//  wallet
//
//  Created by Payam on 5/6/21.
//

import Foundation

class UserLoginViewModel : ObservableObject {
    
    @Published var loginState : Bool = false
    private var privateKey : String? = nil
    
    init(){
        login();
    }
    func login() {
        if (validateKeyExists()){
            loginState = true
        }else {
            loginState = false
        }
    }
    
    func validateKeyExists()-> Bool{
        if(self.privateKey != nil){
            return true
        }
        return false
    }
    func loadKeys() {
        let keychain = Keychain.init()
        setPrivateKey(value: keychain.getKey(key: "privateKey"))
    }
    func setPrivateKey(value: String?){
        self.privateKey = value
    }
    
}
