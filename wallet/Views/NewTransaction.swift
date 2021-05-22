//
//  NewTransaction.swift
//  wallet
//
//  Created by Payam on 5/23/21.
//

import SwiftUI

struct NewTransaction: View {
    @State private var transactionVM = TransactionViewModel()
    var body: some View {
        VStack{
            
            TextField("Recipient Address", text: self.$transactionVM.SendTransaction.RecieverAddress)
            TextField("Amount", value: self.$transactionVM.SendTransaction.Amount, formatter: NumberFormatter())
            TextField("Memo ", text: self.$transactionVM.SendTransaction.Memo)
            
            Button(action: {
               
            }, label: {
                NavigationLink(destination: RecoverWalletView()) {
                     Text("Send")
                 }
            }).accessibility(identifier: "sendAtransaction")
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(50)
            
            
            Spacer()
            
        }.padding()
    }
}

struct NewTransaction_Previews: PreviewProvider {
    static var previews: some View {
        NewTransaction()
    }
}
