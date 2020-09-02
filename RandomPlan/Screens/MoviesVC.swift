//
//  MoviesVC.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 25/08/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {
    
    var moviePoster         = UIImageView()
    var movieTitle          = RPTitleLabel(textAlignment: .center, fontSize: 45)
    var movieDescription    = RPBodyLabel(textAlignment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureMoviePoster()
        configureMovieTitle()
        configureMovieDescription()
        getRandomMovie()
        

    }
    
    func configureViewController() {
        view.backgroundColor                            = .systemBackground
        navigationController?.navigationBar.isHidden    = false
        navigationController?.navigationBar.tintColor   = .systemRed
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "shuffle"), style: .plain, target: self, action: #selector(getRandomMovie))
    }
    
    func configureMoviePoster() {
        view.addSubview(moviePoster)
        
        moviePoster.translatesAutoresizingMaskIntoConstraints   = false
        moviePoster.layer.cornerRadius                          = 10
        moviePoster.layer.borderWidth                           = 3
        moviePoster.clipsToBounds                               = true
        
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            moviePoster.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            moviePoster.heightAnchor.constraint(equalToConstant: 200),
            moviePoster.widthAnchor.constraint(equalToConstant: 120)
        ])
        
    }
    
    func configureMovieTitle() {
        view.addSubview(movieTitle)
        
        movieTitle.numberOfLines    = 3
        let padding:CGFloat         = 10.0
        
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: padding),
            movieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            movieTitle.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func configureMovieDescription() {
        view.addSubview(movieDescription)
        
        movieDescription.numberOfLines  = 10
        let padding:CGFloat             = 20.0
        
        NSLayoutConstraint.activate([
            movieDescription.topAnchor.constraint(equalTo: movieTitle.bottomAnchor),
            movieDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            movieDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            movieDescription.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func getRandomMovie() {
        NetworkManager.shared.getMovies(page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.updateMovie(with: movies)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPosterUrl(movieId: String) {
        NetworkManager.shared.getPosterLink(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let moviePoster):
                if (moviePoster.Poster != "N/A") {
                    self.getPoster(posterUrl: moviePoster.Poster!)
                } else {
                    DispatchQueue.main.async {
                        self.moviePoster.image = UIImage(named: "na")
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPoster(posterUrl: String) {
        NetworkManager.shared.getPoster(from: posterUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.moviePoster.image = image
            }
        }
    }
    
    func updateMovie(with movies: [Movie]) {
        let movie = movies.randomElement()!
        DispatchQueue.main.async {
            self.movieTitle.text        = movie.title
            self.movieDescription.text  = movie.overview
            self.title                  = movie.title
        }
        NetworkManager.shared.getExternalID(movieId: movie.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieExtId):
                self.getPosterUrl(movieId: movieExtId.imdbId)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    

}
