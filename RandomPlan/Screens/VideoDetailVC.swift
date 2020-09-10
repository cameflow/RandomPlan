//
//  VideoDetailVC.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 08/09/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit
import WebKit

class VideoDetailVC: UIViewController {
    
    var video: Video!
    var spinnerView     = UIActivityIndicatorView(style: .large)
    let scrollView      = UIScrollView()
    var videoPlayer     = WKWebView()
    var descriptionText = RPBodyLabel(textAlignment: .left)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureVideoPlayer()
        configureSpinner()
        configureScrollView()
        configureDescription()
    }
    
    
    init(video: Video) {
        super.init(nibName: nil, bundle: nil)
        self.video              = video
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    func configureVideoPlayer() {
        
        view.addSubview(videoPlayer)
        
        videoPlayer.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://www.youtube.com/embed/\(video.videoId)")!
        videoPlayer.load(URLRequest(url: url))
        
        videoPlayer.translatesAutoresizingMaskIntoConstraints = false
        videoPlayer.backgroundColor     = .systemBackground
        videoPlayer.layer.borderColor   = UIColor.black.cgColor
        videoPlayer.layer.borderWidth   = 1
        
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            videoPlayer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            videoPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            videoPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            videoPlayer.heightAnchor.constraint(equalToConstant: (view.frame.width - (padding * 2) ) * (6/9))
        ])
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(descriptionText)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: videoPlayer.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    func configureDescription() {
        
        descriptionText.text            = video.description
        descriptionText.numberOfLines   = 0
        
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            descriptionText.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            descriptionText.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            descriptionText.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            descriptionText.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    
    func configureSpinner() {
        view.addSubview(spinnerView)
        
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.color = .systemRed
        spinnerView.startAnimating()
        
        NSLayoutConstraint.activate([
            spinnerView.centerYAnchor.constraint(equalTo: videoPlayer.centerYAnchor),
            spinnerView.centerXAnchor.constraint(equalTo: videoPlayer.centerXAnchor)
        ])
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if Float(videoPlayer.estimatedProgress) >= 1 {
                spinnerView.stopAnimating()
                spinnerView.removeFromSuperview()
            }
        }
    }


}
