//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Жансая Шакуали on 16.07.2023.
//

import UIKit
struct NetworkManager {
    
    static let shared   = NetworkManager()
    private init() {}
    
    func getmovies(completed: @escaping(Result<Model, ErrorMessage>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/trending/movie/day?api_key=bcb84e23ca94f71116437bf4848a2fed"
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidMovie))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode(Model.self, from: data)
                completed(.success(movies))
            } catch {
                completed(.failure(.unableToComplete))
            }
        }
        task.resume()
    }
}
