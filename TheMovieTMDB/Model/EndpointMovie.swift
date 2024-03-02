//
//  EndpointMovie.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 2.03.24.
//

import Foundation

enum EndpointMovie {
    case topRatedMovies(pageNumber: Int)
    case movieFrom(id: Int)
    case upcomingMovies(pageNumber: Int)
    
    var baseURL:URL {URL(string: "https://api.themoviedb.org/3/movie/")!}
    
    func path() -> String {
        switch self {
        case .topRatedMovies(let pageNumber):
            return "top_rated?language=en-US&page=\(pageNumber)&"
        case .movieFrom(let id):
            return "\(id)?"
        case .upcomingMovies(let pageNumber):
            return "upcoming?language=en-US&page=\(pageNumber)&"
        }
    }
}
