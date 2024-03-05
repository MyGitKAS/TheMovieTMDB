//
//  EndpointMovie.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 2.03.24.
//

import Foundation

enum EndpointMovie {
    case ratedMovies(pageNumber: Int)
    case popularMovies(pageNumber: Int)
    case movieFrom(id: String)
    case upcomingMovies(pageNumber: Int)
    case genres
    case moviesAtGenre(id: String, pageNumber: Int)
    case moviesOn(query: String)

    var baseURL:URL {URL(string: "https://api.themoviedb.org/3/")!}
    
    func path() -> String {
        switch self {
        case .ratedMovies(let pageNumber):
            return "movie/top_rated?language=en-US&page=\(pageNumber)&"
        case .popularMovies(let pageNumber):
            return "movie/popular?language=en-US&page=\(pageNumber)&"
        case .movieFrom(let id):
            return "movie/\(id)?"
        case .upcomingMovies(let pageNumber):
            return "movie/upcoming?language=en-US&page=\(pageNumber)&"
        case .genres:
            return "genre/movie/list?language=en&"
        case .moviesAtGenre(let id, let pageNumber):
            return "discover/movie?with_genres=\(id)&page=\(pageNumber)&"
        case .moviesOn(let query):
            let encodedQuery = query.replacingOccurrences(of: " ", with: "%20")
            return "search/movie?query=\(encodedQuery)&sort_by=title.asc&"        }
    }
}

