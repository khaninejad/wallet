//
//  LoginView.swift
//  wallet
//
//  Created by Payam on 5/4/21.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationView {
        VStack{
            
            Spacer()
            
            Image(systemName: "bitcoinsign.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100.0, height: 100.0, alignment: .center)
                .clipShape(Circle())
             //   .background(Color.blue)
                .foregroundColor(.blue)
            Text("Zarb Coin")
            Spacer()
            
            Button(action: {
               
            }, label: {
                NavigationLink(destination: CreateWalletView()) {
                     Text("Create a Wallet")
                 }
            }).accessibility(identifier: "createAWallet")
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(50)
            
            
           
            
            Text("Or")
            
            Button(action: {
               
            }, label: {
                NavigationLink(destination: CreateWalletView()) {
                     Text("Recover Wallet")
                 }
            }).accessibility(identifier: "recoverAWallet")
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(50)
            
            Spacer()
            
        }
    }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
