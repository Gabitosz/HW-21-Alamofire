//
//  AlamofireManager.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 16.12.2023.
//

import Foundation
import Alamofire

class AlamofireManager {
    
    static var characters: [Character] = []
    
    static func fetchCharacters(countOfCharacters: Int, completion: @escaping () -> Void) {
        let request = AF.request("https://gateway.marvel.com/v1/public/characters?limit=\(countOfCharacters)&ts=1&apikey=cbb2452d6645b4338f0e732373eb6647&hash=dbf085cf11af35cfb528412c9a11d58d")
            request.responseDecodable(of: CharactersResponse.self) { response in
                switch response.result {
                case .success(let charactersResponse):
                    let characters = charactersResponse.data.results
                    self.characters = characters
                    completion()
                case .failure(let error):
                    print("Error: \(error)")
                    completion()
                }
            }
        }
}
