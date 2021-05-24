//
//  APIService.swift
//  wallet
//
//  Created by Payam on 5/24/21.
//

import Foundation

class APIService {
    private let base: String =  "http://172.104.186.100:8081"
    func generateRequest(baseUrl: String, endpointUrl: String, methodType: String, methodBody: Data? , requestToken: String?) -> URLRequest{
        
        guard let url = URL(string: "\(baseUrl)\(endpointUrl)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        if requestToken != nil {
            request.addValue("bearer " + requestToken!, forHTTPHeaderField: "Authorization")
        }
        
        if methodBody != nil {
            request.httpBody = methodBody
        }
        request.httpMethod = methodType
        
        
        return request

    }
    
    
    func getAddress(address: String , completion: @escaping (Address?) -> ()){
       
        let request = generateRequest(baseUrl: base, endpointUrl: "/account/address/\(address)", methodType: "GET", methodBody:  nil, requestToken: nil)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,let httpResponse = response as? HTTPURLResponse, error == nil else{
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard 200 ..< 300 ~= httpResponse.statusCode else {
                print("Status code was \(httpResponse.statusCode), but expected 2xx" )
                  return
              }
            
            
            let addressReponse = try? JSONDecoder().decode(Address.self, from: data)
            
            if let addressReponse = addressReponse{
                DispatchQueue.main.async {
                    completion(addressReponse)
                }
            }
            
            
        }.resume()
            
    }
    
    func getBlockChainHeight(completion: @escaping (BlockChainHeight?) -> ()){
       
        let request = generateRequest(baseUrl: base, endpointUrl: "/blockchain/", methodType: "GET", methodBody:  nil, requestToken: nil)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,let httpResponse = response as? HTTPURLResponse, error == nil else{
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard 200 ..< 300 ~= httpResponse.statusCode else {
                print("Status code was \(httpResponse.statusCode), but expected 2xx" )
                  return
              }
            
            
            let blockchainHeightReponse = try? JSONDecoder().decode(BlockChainHeight.self, from: data)
            
            if let blockchainHeightReponse = blockchainHeightReponse{
                DispatchQueue.main.async {
                    completion(blockchainHeightReponse)
                }
            }
            
            
        }.resume()
            
    }
    
    ///
    
    func getBlockChainHeightHash(height: Int, completion: @escaping (BlockChainHash?) -> ()){
       
        let request = generateRequest(baseUrl: base, endpointUrl: "/block/height/\(height)", methodType: "GET", methodBody:  nil, requestToken: nil)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,let httpResponse = response as? HTTPURLResponse, error == nil else{
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard 200 ..< 300 ~= httpResponse.statusCode else {
                print("Status code was \(httpResponse.statusCode), but expected 2xx" )
                  return
              }
            
            
            let blockchainHeightReponse = try? JSONDecoder().decode(BlockChainHash.self, from: data)
            
            if let blockchainHeightReponse = blockchainHeightReponse{
                DispatchQueue.main.async {
                    completion(blockchainHeightReponse)
                }
            }
            
            
        }.resume()
            
    }
    
    
    
    
    
    
    
}
