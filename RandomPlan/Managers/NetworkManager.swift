//
//  NetworkManager.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 31/08/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared           = NetworkManager()
    private let baseURL_movie   = "https://api.themoviedb.org/3/"
    private let baseURL_poster  = "https://img.omdbapi.com/"
    private let baseURL_omdb    = "https://www.omdbapi.com/"
    private let baseURL_yt      = "https://www.googleapis.com/youtube/v3/"
    private init() {}
    private var moviesArr:[Movie] = []

    func getMovies(page: Int, completed: @escaping (Result<[Movie], RPError>) -> Void) {
        let endpoint    = baseURL_movie + "movie/popular?api_key=\(Constant.THEMOVIEDB_API_KEY)&language=en-US&page=\(page)"
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
    
    func getPoster(from url: String, completed: @escaping (UIImage?) -> Void) {
        let endpoint    = url
        
        guard let url   = URL(string: endpoint) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let _ = self,
                error           == nil,
                let response    = response as? HTTPURLResponse, response.statusCode == 200,
                let data        = data,
                let image       = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            completed(image)
        }
        task.resume()
        
    }
    
    func getExternalID(movieId: Int, completed: @escaping (Result<MovieExternalID, RPError>) -> Void) {
        let endpoint    = baseURL_movie + "movie/\(movieId)/external_ids?api_key=a8e53f1594c1ba9c7b98e0869bb2c86f"
        guard let url   = URL(string: endpoint) else { return }
        
        let task        = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let response  = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data      = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movieExternalId = try decoder.decode(MovieExternalID.self, from: data)
                completed(.success(movieExternalId))
            } catch {
                completed(.failure(.wrongData))
                return
            }
        }
        task.resume()
    }
    
    func getPosterLink(movieId: String, completed: @escaping (Result<MoviePoster, RPError>) -> Void) {
        let endpoint    =  baseURL_omdb + "/?apikey=\(Constant.OMDB_API_KEY)&i=\(movieId)"
        
        guard let url   = URL(string: endpoint) else { return }
        
        let task        = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let response  = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data      = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let moviePoster = try decoder.decode(MoviePoster.self, from: data)
                completed(.success(moviePoster))
            } catch {
                completed(.failure(.wrongData))
                return
            }
        }
        task.resume()
    }
    
    func getPlaylistVideos(playlistId: String, completed: @escaping (Result<[Video],RPError>) -> Void){
        let endpoint = baseURL_yt + "playlistItems?part=snippet&maxResults=10&playlistId=\(playlistId)&key=\(Constant.YT_API_KEY)"
        guard let url = URL(string: endpoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response  = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data      = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let playlist = try decoder.decode(Playlist.self, from: data)
                completed(.success(playlist.items))
            } catch {
                completed(.failure(.wrongData))
                return
            }            
        }
        task.resume()
        
        
    }
    
}



