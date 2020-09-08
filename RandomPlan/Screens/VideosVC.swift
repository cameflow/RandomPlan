//
//  VideosVC.swift
//  RandomPlan
//
//  Created by Alejandro Terrazas on 07/09/20.
//  Copyright © 2020 Alejandro Terrazas. All rights reserved.
//

import UIKit

class VideosVC: UIViewController {

    let tableView       = UITableView()
    var videos:[Video]  = []
    var playlistId:String!
    
    init(playlistId: String) {
        super.init(nibName: nil, bundle: nil)
        self.playlistId   = playlistId
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getVideos()

    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(VideoCell.self, forCellReuseIdentifier: VideoCell.reuseID)
    }
    
    func getVideos() {
        NetworkManager.shared.getPlaylistVideos(playlistId: playlistId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let videos):
                self.updateUI(with: videos)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateUI(with videos: [Video]) {
        self.videos = videos
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
    }
 
}

extension VideosVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.reuseID) as! VideoCell
        let video = videos[indexPath.row]
        cell.set(video: video)
        return cell
    }
}
