//
//  NetworkManager.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 31/08/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared   = NetworkManager()
    private let baseURL = "https://api.themoviedb.org/3/"
    
    private init() {}
    private var moviesArr:[Movie] = []

    func getMovies(page: Int, completed: @escaping (Result<[Movie], RPError>) -> Void) {
        let endpoint    = baseURL + "movie/popular?api_key=a8e53f1594c1ba9c7b98e0869bb2c86f&language=en-US&page=\(page)"
        guard let url   = URL(string: endpoint) else { return }
        
        let task        = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let response  = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data      = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode(APIResponse.self, from: data)
                completed(.success(movies.results))
            } catch {
                completed(.failure(.wrongData))
                return
            }
        }
        task.resume()
    }
}

