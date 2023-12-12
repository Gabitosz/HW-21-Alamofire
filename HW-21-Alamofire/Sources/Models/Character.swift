//
//  Character.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 12.12.2023.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let comics: Comics
    let events: Events
}

struct Comic: Codable {
    let name: String
}

struct Comics: Codable {
    let available: Int
    let items: [Comic]
}

struct Event: Codable {
    let name: String
}

struct Events: Codable {
    let available: Int
    let items: [Event]
}
