//
//  Genres.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 3.03.24.
//

import Foundation

// MARK: - Genres
struct Genres: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
