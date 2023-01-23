//
//  RickAndMorty.swift
//  MVVMRickAndMorty
//
//  Created by Татьяна on 09.12.2022.
//

import Foundation

struct RickAndMorty: Codable {
    let info: Info
    let results: [Hero]
}

struct Info: Codable {
    let pages: Int
    let next: String?
    let prev: String?
}

struct Hero: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    var description: String {
        """
        Species: \(species)
        Gender: \(gender)
        Origin: \(origin.name)
        Status: \(origin.name)
        """
    }
}

struct Location: Codable {
    let name: String
    let url: String
}

struct Episode: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}

