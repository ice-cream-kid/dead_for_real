//
//  SetlistGenerator.swift
//  dead for real
//
//  Created by Michael Johnson on 11/23/22.
//

import Foundation

// setlistFM API key: _RYJGzYOFgqCITzykUaPqaidvqCFkdl6RNa2

class SetlistGenerator {
    
    func generateSetlistData() {
        
        let setlist_API_Key = "_RYJGzYOFgqCITzykUaPqaidvqCFkdl6RNa2"
        let mbid = "6faa7ca7-0d99-4a5e-bfa6-1fd5037520c6"
        let setlistURL = "https://api.setlist.fm/rest/1.0/search/setlists?artistMbid=\(mbid)&p=1"
        
        guard let url = URL(string: "\(setlistURL)") else {
            print("invalid url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("\(setlist_API_Key)", forHTTPHeaderField: "x-api-key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            
            if String(data: data, encoding: .utf8) != nil {
                
//            if let str = String(data: data, encoding: .utf8) {
//            print(str)
               
                do {
                    let allShowData = try JSONDecoder().decode(Setlists.self, from: data)
                    print(allShowData)

                } catch let parseError {
                    print(" \n *** \n ", parseError)
                }
            }
            
        }.resume()
    }
}
