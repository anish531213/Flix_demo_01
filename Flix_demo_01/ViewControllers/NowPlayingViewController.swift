//
//  NowPlayingViewController.swift
//  Flix_demo_01
//
//  Created by Anish Adhikari on 1/17/18.
//  Copyright © 2018 Anish Adhikari. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.rowHeight = 161
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (NowPlayingViewController.didPullToRefresh(_:)),  for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 1)
        
        fetchMovies()
        activityIndicator.stopAnimating()
        // Do any additional setup after loading the view.
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMovies()
    }
    
     func fetchMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=946e1a7e73e67b8395a09bcc57800281")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when network request returns
            if let error = error {
                
                let alert = UIAlertController(title: "Cannot Get Movies", message: "The internet connection appears to be offline", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Try Again", style: .cancel) { (action) in
                    
                    self.fetchMovies()
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
                
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text  = overview
    
        let posterPathString = movie["poster_path"] as! String
        
        let baseUrlString = "https://image.tmdb.org/t/p/w500"
        let posterUrl = URL(string: baseUrlString+posterPathString)!
        cell.posterImageView.af_setImage(withURL: posterUrl)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
