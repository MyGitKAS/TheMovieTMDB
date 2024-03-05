//
//  EndpointImage.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 4.03.24.
//

import Foundation

enum EndpointImage {
    case posterUrl(width: Int, idImage: String)
    
    var baseURL:String { "https://image.tmdb.org/t/p/" }
    
    func path() -> String {
        switch self {
        case .posterUrl(let width, let idImage):
            return "\(baseURL)w\(width)\(idImage)"
   
        }
    }
}
