//
//  Webservice.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 7.07.2022.
//

import Foundation

class NetworkService{
    
    func decode<T: Decodable>(url: String) -> T {
        guard let url            = URL(string: url) else {
            fatalError("Could not find data!")
        }
        
        guard let data            = try? Data(contentsOf: url) else {
            fatalError("Could not load.")
        }
        
        let decoder              = JSONDecoder()
        guard let loadedData     = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode")
        }
        return loadedData
    }
    
    
    func fetchData<T: Decodable>(url: String, model: T.Type, completion: @escaping (T) -> (), failure: @escaping(Error) -> ()) {
        
        guard let url           = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data      = data else {
                if let error    = error {
                    failure(error)
                }
                return
            }
            do {
                let serverData   = try JSONDecoder().decode(T.self, from: data)
                completion(serverData)
            } catch {
                failure(error)
            }
        }.resume()
    }
    
    
}

