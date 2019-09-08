//
//  APIHandler.swift
//  SMETest
//
//  Created by shiva on 08/09/19.
//  Copyright © 2019 UdayKumar. All rights reserved.
//

import Foundation

public class APIHandler : NSObject{
    
    static var shared = APIHandler()
    weak var LoadingDelegate : LoadingIndicatorDelegate?
    
    func GetDataFromApi( urlString:String, CompletionHandler: @escaping (NSData) -> ()) {
        
        let urlstring = urlString.trimmingCharacters(in: .whitespaces)
        guard let url = URL(string: urlstring) else{
            return
        }
        
        LoadingDelegate?.DidStartLoading()
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data,response,error) in
            guard error == nil else{
                print(error?.localizedDescription ?? "Something went wrong.")
                self.LoadingDelegate?.LoadingFinished()
                return
            }
            
            if let data = data{
                
                CompletionHandler(data as NSData)
                
            }
            
        }).resume()
        
        
    }
    
    
}
