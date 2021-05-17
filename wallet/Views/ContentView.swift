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
        
    }
    var body: some View {
        if (userLoginVM.loginState){
             DashboardView()
        }else{
            LoginView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
