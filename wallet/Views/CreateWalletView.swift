//
//  CreateWalletView.swift
//  wallet
//
//  Created by Payam on 5/4/21.
//

import SwiftUI

struct CreateWalletView: View {
    @ObservedObject private var walletVM = WalletViewModel()

    var body: some View {
        VStack {
            Text("Save these words in safe place!")
            
            List {
                ForEach(self.walletVM.keys.mnemonicWords, id: \.self) { item in
                    Text(item)
                    
                    }
                }
            
        }
        .onAppear {
            walletVM.Generate()
        }
        
        Button(action: {
           
        }, label: {
            NavigationLink(destination: DashboardView()) {
                 Text("Take me to the Zarb Wallet")
             }
        }).accessibility(identifier: "gotoZarbAWallet")
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(50)
        
        
          
    }
}

struct CreateWalletView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWalletView()
    }
}
