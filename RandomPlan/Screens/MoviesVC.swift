//
//  MoviesVC.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 25/08/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {
    
    var movieTitle          = RPTitleLabel(textAlignment: .center, fontSize: 45)
    var movieDescription    = RPBodyLabel(textAlignment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureMovieTitle()
        configureMovieDescription()
        getRandomMovie()
        

    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "shuffle"), style: .plain, target: self, action: #selector(getRandomMovie))
    }
    
    func configureMovieTitle() {
        view.addSubview(movieTitle)
        
        movieTitle.numberOfLines    = 3
        let padding:CGFloat         = 20.0
        
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            movieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            movieTitle.heightAnchor.constraint(equalToConstant: 200)
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
    
    func updateMovie(with movies: [Movie]) {
        DispatchQueue.main.async {
            let movie = movies.randomElement()!
            self.movieTitle.text = movie.title
            self.movieDescription.text = movie.overview
        }
        
    }
    

}
