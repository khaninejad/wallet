//
//  TransactionViewModel.swift
//  wallet
//
//  Created by Payam on 5/23/21.
//

import Foundation

class TransactionViewModel {
    var SendTransaction = TransactionFields()
    let keychainWrapper = Keychain.init()
    let apiService =  APIService.init()
    private var CBORTransaction = CBORWrapper.init()
    private var numberOfTransaction = 0
    private var latestBlock = 0
    private var latestBlockHash = ""
    init() {
        
    }
    
    func Send(){
        let group = DispatchGroup()

      
        getTransactionNumber(group: group)
      
        let publicKey = self.keychainWrapper.getKey(key: "publicKey")!
        let signedMessage = "msg"

        getBlockChainHeight(group: group)
        getBlockChainHeightHash(height: self.latestBlock, group: group)

        group.notify(queue: .main) { [self] in
        print (self.numberOfTransaction)
            print(self.latestBlock)
            self.CBORTransaction.setSendPayload(sender: self.keychainWrapper.getKey(key: "address")!, reciver: self.SendTransaction.RecieverAddress, amount:Int( self.SendTransaction.Amount)!)
            let hex =   self.CBORTransaction.setTransactionPayload(publicKey: publicKey, signature: signedMessage, latestBlockStamp: self.latestBlockHash, numberOfSenderTransaction: self.numberOfTransaction, fee: 1000, memo: self.SendTransaction.Memo)
            print(hex)
            
        }
        
        
    }
        
    func getTransactionNumber(group: DispatchGroup) {
        group.enter()
        
            self.apiService.getAddress(address: self.keychainWrapper.getKey(key: "address")!) { address in
            let address =   address.map(AddressViewModel.init)
            self.numberOfTransaction = address?.sequence ?? 0
            group.leave()
         }
    }
    
    func getBlockChainHeight(group: DispatchGroup) {
        group.enter()
        apiService.getBlockChainHeight() { height in
            let height =    height.map(BlockChainHeightViewModel.init)
            if height != nil {
                self.latestBlock = (height?.blockChainHeight.height)!
                group.leave()
            }
            
         }
    }
    func getBlockChainHeightHash(height: Int, group: DispatchGroup) {
        group.enter()
        apiService.getBlockChainHeightHash(height: height) { height in
            
            let height =    height.map(BlockChainHeightHashViewModel.init)
            if height != nil {
                self.latestBlockHash = (height?.blockChainHeightHash.hash)!
                group.leave()
            }
            
         }
    }
}


struct TransactionFields: Decodable {
    var RecieverAddress: String = ""
    var Amount: String = "0"
    var Memo : String = ""
    
}

class BlockChainHeightViewModel {
    var blockChainHeight : BlockChainHeight
    init(height: BlockChainHeight) {
        self.blockChainHeight = height
    }


    var height: Int? {
        return self.blockChainHeight.height
    }

}

class BlockChainHeightHashViewModel {
    var blockChainHeightHash : BlockChainHash
    init(height: BlockChainHash) {
        self.blockChainHeightHash = height
    }


    var Hash: String? {
        return self.blockChainHeightHash.hash
    }

}
