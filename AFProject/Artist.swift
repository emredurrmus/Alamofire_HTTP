//
//  Artist.swift
//  AFProject
//
//  Created by Emre Durmuş on 28.06.2023.
//

import Foundation


struct Artist : Codable {
    let results: [ArtistResults]
}



struct ArtistResults : Codable {
    let trackName : String
    let artistName : String
    let artworkUrl60 : String
    let country : String
}
