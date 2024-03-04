//
//  NetworkManager.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 2.03.24.
//

import UIKit

class NetworkManager {
    
   static private let key = "6893d4d853e6acfbfc8cecb19397223f"
    
   static func getData(endpoint: EndpointMovie, completion: @escaping (Result<Movies?, Error>) -> Void) {
        guard let url = URL(string:"\(endpoint.baseURL)\(endpoint.path())api_key=\(key)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        fetch(url) { (result: Result<Movies, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
   static func getOneMovie(endpoint: EndpointMovie, completion: @escaping (Result<Movie?, Error>) -> Void) {
        guard let url = URL(string:"\(endpoint.baseURL)\(endpoint.path())api_key=\(key)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        fetch(url) { (result: Result<Movie, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
   static func getGenres(endpoint: EndpointMovie, completion: @escaping (Result<Genres?, Error>) -> Void) {
        guard let url = URL(string:"\(endpoint.baseURL)\(endpoint.path())api_key=\(key)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        fetch(url) { (result: Result<Genres, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
   static func downloadImageWith(urlString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let stringUrl = urlString, let url = URL(string: stringUrl) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil {
                completion(nil)
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
    
   static private func fetch<T: Codable>(_ url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noDataReceived))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let fetchedData = try decoder.decode(T.self, from: data)
                completion(.success(fetchedData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noDataReceived
    case unableToCreateImage
}
