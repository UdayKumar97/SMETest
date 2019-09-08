//
//  HViewModel.swift
//  SMETest
//
//  Created by shiva on 08/09/19.
//  Copyright © 2019 UdayKumar. All rights reserved.
//

import Foundation

protocol LoadingIndicatorDelegate:AnyObject{
    func DidStartLoading()
    func LoadingFinished()
}

class HViewModel : NSObject{
    
    var Types = ["album","artist","track"]
    weak var LoadingDelegate : LoadingIndicatorDelegate?
    
    fileprivate func GetResultsFromService(_ typeString:String, _ SearchString:String, CompletionHandler:@escaping ([Album]) -> ()) {
        var Albums = [Album]()
        
        APIHandler.shared.GetDataFromApi(urlString: "http://ws.audioscrobbler.com/2.0/?method=\(typeString).search&\(typeString)=\(SearchString)&api_key=e4777bdc6e4597534c8373a0bb25647b&format=json&limit=7", CompletionHandler: {
            (data) in
            
            do {
                let jsonObject = try JSONDecoder().decode(SearchResult.self, from: data as Data)
                
                if  let albums = jsonObject.results.albummatches?.album{
                    Albums = albums
                }else if let albums = jsonObject.results.artistmatches?.artist{
                    Albums = albums
                }else if let albums = jsonObject.results.trackmatches?.track{
                    Albums = albums
                }
                self.LoadingDelegate?.LoadingFinished()
                CompletionHandler(Albums)
                
                
            }catch{
                
                CompletionHandler(Albums)
                 self.LoadingDelegate?.LoadingFinished()
            }
            
        })
        
    }
    
    func GetSongInfoModels(_ SearchString:String, CompletionHandler:@escaping ([[SongInfoModel]]) -> ()){
        
        var SongInfoModels = [[SongInfoModel]]()
        let dispatchGroup = DispatchGroup()
        
        for type in Types{
            var songModels = [SongInfoModel]()
            dispatchGroup.enter()
            GetResultsFromService(type, SearchString, CompletionHandler: {
                Albums in
                for album in Albums{
                    songModels.append(SongInfoModel.init(type: type, name: album.name ?? "", artist: album.artist ?? "", ImageUrl: album.image[2].text!))
                }
                
                SongInfoModels.append(songModels)
                dispatchGroup.leave()
            })
            
        }
        
        dispatchGroup.notify(queue: .main) {
            CompletionHandler(SongInfoModels)
        }
        
    }
    
    
    
   
    
}

