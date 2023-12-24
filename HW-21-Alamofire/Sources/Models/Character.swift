//
//  Character.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 12.12.2023.
//

import Foundation

struct CharactersResponse: Decodable {
    let data: Characters
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}

struct Characters: Decodable {
    let results: [Character]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct Character: Decodable {
    let id: Int
    let name: String
    let description: String
    let comics: Comics
    let events: Events
    let image: Image
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case comics
        case events
        case image = "thumbnail"
    }
}

struct Comic: Decodable {
    let name: String
}

struct Comics: Decodable {
    let available: Int
    let items: [Comic]
}

struct Event: Decodable {
    let name: String
}

struct Events: Decodable {
    let available: Int
    let items: [Event]
}

struct Image: Decodable {
    let path: String
    let `extension`:  String
    var imageURL: String {
        return path + "/portrait_xlarge." + `extension`
    }
}



