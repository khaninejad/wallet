//
//  ContentView.swift
//  wallet
//
//  Created by Payam on 5/3/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var userLoginVM = UserLoginViewModel()
   
    init() {
        if (userLoginVM.loginState){
            
        }
    }
    var body: some View {
      return  LoginView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
