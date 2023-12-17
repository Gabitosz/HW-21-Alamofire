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

