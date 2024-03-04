//
//  EndpointMovie.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 2.03.24.
//

import Foundation

enum EndpointMovie {
    case topRatedMovies(pageNumber: Int)
    case popularMovies(pageNumber: Int)
    case movieFrom(id: String)
    case upcomingMovies(pageNumber: Int)
    case getGenres
    case getMoviesAtGenre(id: String, pageNumber: Int)
    
    var baseURL:URL {URL(string: "https://api.themoviedb.org/3/")!}
    
    func path() -> String {
        switch self {
        case .topRatedMovies(let pageNumber):
            return "movie/top_rated?language=en-US&page=\(pageNumber)&"
        case .popularMovies(let pageNumber):
            return "movie/popular?language=en-US&page=\(pageNumber)&"
        case .movieFrom(let id):
            return "movie/\(id)?"
        case .upcomingMovies(let pageNumber):
            return "movie/upcoming?language=en-US&page=\(pageNumber)&"
        case .getGenres:
            return "genre/movie/list?language=en&"
        case .getMoviesAtGenre(let id, let pageNumber):
            return "discover/movie?with_genres=\(id)&page=\(pageNumber)&"
        }
    }
}

//https://api.themoviedb.org/3/discover/movie?with_genres=18&api_key=6893d4d853e6acfbfc8cecb19397223f
