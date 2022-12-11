//
//  characters.swift
//  MP
//
//  Created by admin on 12/7/22.
//


import Foundation

struct RickAndMortyCharacters : Codable {
    var results: [RickAndMortyCharacter]
}

struct RickAndMortyCharacter : Codable {
    
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender : String
    var image: String
    
}

struct AnimeCharacters: Codable {
    var data:[Characters]
}

struct Characters: Codable {
    var character : Character
 
  
}

struct Character : Codable {
    var mal_id: Int
    var images: CharacterImages
    var name: String
}



struct FullAnimeCharactersData: Codable {
    var data: AnimeCharactersData
    
}
struct AnimeCharactersData: Codable {
    var name: String?
    var about: String?
   var nicknames: [String]
    var images: CharacterImages
}

struct CharacterImages:Codable {
    var jpg : jpg
}
struct jpg: Codable {
    var image_url: String
}
