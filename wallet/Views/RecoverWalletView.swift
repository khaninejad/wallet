//
//  RecoverWalletView.swift
//  wallet
//
//  Created by Payam on 5/4/21.
//

import SwiftUI

struct RecoverWalletView: View {
//    @State private var words = [String](repeating: "", count:23)
    @State private var words = ["comic",
                                   "yard",
                                   "general",
                                   "scout",
                                   "fork",
                                    "unit",
                                   "feed",
                                    "dawn",
                                    "unlock",
                                    "broken",
                                    "appear",
                                    "ready",
                                   "salmon",
                                   "topple",
                                    "dragon",
                                    "follow",
                                     "embrace",
                                   "prize",
                                     "lawsuit",
                                    "horse",
                                     "bulb",
                                     "bullet",
                                    "table",
                                     "wait"]
    var body: some View {
        VStack {
        
        Text("Please enter the recovery words to restore your wallet!")
        Form {
            ForEach(0..<23) {index in
            HStack {
                TextField("word \(index)", text: self.$words[index])
            }
        }
            
          
        }
            Button(action: {
                WalletViewModel.init().RecoverKeys(words: self.words)
            }, label: {
                
                     Text("Recover")
               
            }).accessibility(identifier: "recoverTheWallet")
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(50)
        }
        
    }
}

struct RecoverWalletView_Previews: PreviewProvider {
    static var previews: some View {
        RecoverWalletView()
    }
}
