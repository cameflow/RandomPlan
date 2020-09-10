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
    var spinnerView         = UIActivityIndicatorView(style: .large)
    var movieTitle          = RPTitleLabel(textAlignment: .center, fontSize: 35)
    var movieDescription    = RPBodyLabel(textAlignment: .center)
    var movieRate           = RPBodyLabel(textAlignment: .left)
    var movieDuration       = RPBodyLabel(textAlignment: .left)
    var movieReleaseDate    = RPBodyLabel(textAlignment: .left)
    var movieDirector       = RPBodyLabel(textAlignment: .left)
    var moviesList:[Movie]  = []
    var page                = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureMovieTitle()
        configureMoviePoster()
        configureSpinner()
        configureMovieRate()
        configureMovieDuration()
        configureMovieReleaseDate()
        configureMovieDirector()
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
        
        let borderColor                                         = UIColor.systemGray.cgColor
        moviePoster.translatesAutoresizingMaskIntoConstraints   = false
        moviePoster.layer.cornerRadius                          = 10
        moviePoster.layer.borderWidth                           = 3
        moviePoster.layer.borderColor                           = borderColor
        moviePoster.clipsToBounds                               = true
        
        NSLayoutConstraint.activate([
            moviePoster.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 20),
            moviePoster.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            moviePoster.heightAnchor.constraint(equalToConstant: 200),
            moviePoster.widthAnchor.constraint(equalToConstant: 120)
        ])
        
    }
    
    func configureMovieTitle() {
        view.addSubview(movieTitle)
        
        movieTitle.numberOfLines    = 3
        let padding:CGFloat         = 20.0
        
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            movieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            movieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            movieTitle.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureMovieRate() {
        view.addSubview(movieRate)
        movieRate.translatesAutoresizingMaskIntoConstraints = false
        
        let padding:CGFloat = 20.0
        
        NSLayoutConstraint.activate([
            movieRate.topAnchor.constraint(equalTo: moviePoster.topAnchor, constant: padding),
            movieRate.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: padding),
            movieRate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            movieRate.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureMovieDuration() {
        view.addSubview(movieDuration)
        movieDuration.translatesAutoresizingMaskIntoConstraints = false
        
        let padding:CGFloat = 20.0
        
        NSLayoutConstraint.activate([
            movieDuration.topAnchor.constraint(equalTo: movieRate.bottomAnchor, constant: padding),
            movieDuration.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: padding),
            movieDuration.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            movieDuration.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureMovieReleaseDate() {
        view.addSubview(movieReleaseDate)
        movieReleaseDate.translatesAutoresizingMaskIntoConstraints = false
        
        let padding:CGFloat = 20.0
        
        NSLayoutConstraint.activate([
            movieReleaseDate.topAnchor.constraint(equalTo: movieDuration.bottomAnchor, constant: padding),
            movieReleaseDate.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: padding),
            movieReleaseDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            movieReleaseDate.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureMovieDirector() {
        view.addSubview(movieDirector)
        movieDirector.translatesAutoresizingMaskIntoConstraints = false
        let padding:CGFloat = 20.0
        
        NSLayoutConstraint.activate([
            movieDirector.topAnchor.constraint(equalTo: movieReleaseDate.bottomAnchor, constant: padding),
            movieDirector.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: padding),
            movieDirector.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            movieDirector.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureMovieDescription() {
        view.addSubview(movieDescription)
        
        movieDescription.numberOfLines  = 0
        let padding:CGFloat             = 20.0
        
        NSLayoutConstraint.activate([
            movieDescription.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: padding),
            movieDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            movieDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            movieDescription.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureSpinner() {
        view.addSubview(spinnerView)
        spinnerView.hidesWhenStopped = true
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.color = .systemRed
        spinnerView.startAnimating()
        view.bringSubviewToFront(spinnerView)
        
        NSLayoutConstraint.activate([
            spinnerView.centerYAnchor.constraint(equalTo: moviePoster.centerYAnchor),
            spinnerView.centerXAnchor.constraint(equalTo: moviePoster.centerXAnchor)
        ])
    }
    
    @objc func getRandomMovie() {
        
        if page > 500 { page = 1 }
        NetworkManager.shared.getMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.updateMovie(with: movies)
                self.page += 1
            case .failure(let error):
                let alert = UIAlertController(title: "Something went wrong", message: error.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
                
            }
        }
    }
    
    func getPosterUrl(movieId: String) {
        
        DispatchQueue.main.async {
            //self.moviePoster.image = UIImage(named: "loading")
            self.spinnerView.startAnimating()
            
            
        }
        
        NetworkManager.shared.getPosterLink(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let moviePoster):
                DispatchQueue.main.async {
                    self.movieRate.text = "Rated: \(moviePoster.Rated)"
                    self.movieDuration.text = "Druation: \(moviePoster.Runtime)"
                    self.movieReleaseDate.text = "Released: \(moviePoster.Released)"
                    self.movieDirector.text = "Directed by: \(moviePoster.Director)"
                }
                if (moviePoster.Poster != "N/A") {
                    self.getPoster(posterUrl: moviePoster.Poster!)
                } else {
                    DispatchQueue.main.async {
                        self.moviePoster.image = UIImage(named: "na")
                    }
                }
                
            case .failure(let error):
                let alert = UIAlertController(title: "Something went wrong", message: error.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func getPoster(posterUrl: String) {
        NetworkManager.shared.getPoster(from: posterUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.moviePoster.image = image
                self.spinnerView.stopAnimating()
            }
        }
    }
    
    func updateMovie(with movies: [Movie]) {
        moviesList.append(contentsOf: movies)
        let movie = moviesList.randomElement()!
        DispatchQueue.main.async {
            self.movieTitle.text        = movie.title
            self.movieDescription.text  = movie.overview
            self.title                  = "Movie"
            self.tabBarItem.title       = "Movie"
        }
        NetworkManager.shared.getExternalID(movieId: movie.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieExtId):
                self.getPosterUrl(movieId: movieExtId.imdbId)
            case .failure(let error):
                let alert = UIAlertController(title: "Something went wrong", message: error.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            }
        }
        
    }
    

}
