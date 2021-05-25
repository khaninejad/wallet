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
    private var signature = ""
    init() {
        
    }
    
    func Send(){
      

        
        let group = DispatchGroup()
        
        
        getTransactionNumber(group: group)
        
        let publicKey = self.keychainWrapper.getKey(key: "publicKey")!
        
        getBlockChainHeight(group: group)
       
        
        jsonData(group: group)
        
        group.notify(queue: .main) { [self] in
            print (self.numberOfTransaction)
            print(self.latestBlock)
            self.CBORTransaction.setSendPayload(sender: self.keychainWrapper.getKey(key: "address")!, reciver: self.SendTransaction.RecieverAddress, amount:Int( self.SendTransaction.Amount)!)
            if (self.signature != "" && self.latestBlockHash != "" && self.latestBlock > 0) {
                let hex =   self.CBORTransaction.setTransactionPayload(publicKey: publicKey, signature: self.signature, latestBlockStamp: self.latestBlockHash, numberOfSenderTransaction: self.numberOfTransaction, fee: 1000, memo: self.SendTransaction.Memo)
                print(hex)
            }
           
            
        }
        
        
    }
    func jsonData(group: DispatchGroup){
        group.enter()
        let payloadTemp = TransactionSendPayloadTemp(sender:   self.keychainWrapper.getKey(key: "address")!.bytes, reciever:  self.SendTransaction.RecieverAddress.bytes, amount: Int( self.SendTransaction.Amount)!)
        let tranasctionPayloadTemp = TransactionPayloadTemp(Version: 1, Stamp: self.latestBlockHash.bytes, Sequence: self.numberOfTransaction, Fee: 1000, type: 1, Payload: payloadTemp, Memo: self.SendTransaction.Memo)
        
        let jsonData = try! JSONEncoder().encode(tranasctionPayloadTemp)
         let jsonString = String(data: jsonData, encoding: .utf8)!
            let bls = BLS()
        self.signature =  bls.Sign(msg: jsonString, secretkey: self.keychainWrapper.getKey(key: "privateKey")!)
        group.leave()
    }
    func getTransactionNumber(group: DispatchGroup) {
        group.enter()
        self.numberOfTransaction = 0
        self.apiService.getAddress(address: self.keychainWrapper.getKey(key: "address")!) { address in
            let address =   address.map(AddressViewModel.init)
            self.numberOfTransaction = address?.sequence ?? 0
           
        }
        
        group.leave()
    }
    
    func getBlockChainHeight(group: DispatchGroup) {
        group.enter()
        apiService.getBlockChainHeight() { height in
            let height =    height.map(BlockChainHeightViewModel.init)
            if height != nil {
                self.latestBlock = (height?.blockChainHeight.height)!
                self.getBlockChainHeightHash(height: (height?.blockChainHeight.height)!,group: group)
            }
            group.leave()
        }
    }
    func getBlockChainHeightHash(height: Int, group: DispatchGroup) {
        group.enter()
        apiService.getBlockChainHeightHash(height: height) { height in
            
            let height =    height.map(BlockChainHeightHashViewModel.init)
            if height != nil {
                self.latestBlockHash = (height?.blockChainHeightHash.hash)!
               
            }
            group.leave()
            
        }
    }
}


struct TransactionFields: Decodable {
    var RecieverAddress: String = "zrb1cguu8dxv65vcd064ct3c4t2dta0pn0eyx5x2nw"
    var Amount: String = "100"
    var Memo : String = "JHSGTB12"
    
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


struct TransactionPayloadTemp : Encodable {
    var Version: Int
    var  Stamp   :  [UInt8]
    var  Sequence :  Int
    var  Fee    :   Int
    var type : Int
    var  Payload : TransactionSendPayloadTemp
    var  Memo   :   String
    private enum CodingKeys : String, CodingKey {
            case Version, Stamp,Sequence,Fee, type = "Type", Payload, Memo
        }
}
struct TransactionSendPayloadTemp : Encodable {
    init(sender: [UInt8], reciever: [UInt8], amount: Int) {
        self.Receiver = sender
        self.Amount = amount
        self.Sender = reciever
    }
    var Sender: [UInt8]
    var  Receiver   :  [UInt8]
    var  Amount :  Int
}
