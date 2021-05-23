//
//  DashboardViewModel.swift
//  wallet
//
//  Created by Payam on 5/24/21.
//

import Foundation
class BalanceViewModel : ObservableObject {
    let apiService =  APIService.init()
    let keychainWrapper = Keychain.init()
    @Published var balance : AddressViewModel?
    @Published var balanceLoaded : Bool = false
    
    init(){
        LoadBalance()
    }
    
    func LoadBalance()  {
        let address = keychainWrapper.getKey(key: "address")
        if address != nil {
            apiService.getAddress(address: keychainWrapper.getKey(key: "address")!) { address in
                self.balance =   address.map(AddressViewModel.init)
                if self.balance?.address != "" {
                    self.balanceLoaded = true
                }
             }
        }
        
    }
}
