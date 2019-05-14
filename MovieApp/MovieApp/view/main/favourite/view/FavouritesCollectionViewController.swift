//
//  FavouritesCollectionViewController.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/11/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
private let reuseIdentifier = "movieCell"

class FavouritesCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout  {
    var movies : [NSManagedObject]!;
     var destinationVC : MovieDetailsViewController!
    let dataLayer : DataLayer = DataLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        movies = dataLayer.getFavouriteMovies()
        print("Saved Movies : \(movies.count)")
        self.collectionView?.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.destinationVC = segue.destination as? MovieDetailsViewController
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        let imageLink  = (movies![indexPath.row].value(forKey: MoviesEntity.posterPath.rawValue) as! String)
        cell.favouritePosterImage.sd_setImage(with: URL(string: imageLink), placeholderImage: UIImage(named: "placeholder.jpg"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 8 * 2) / 2 //some width
        let height = width * 275 / 185 //ratio
        return CGSize(width: width, height: height)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let clickedMovie: Movie = Movie()
        clickedMovie.id = (movies![indexPath.row].value(forKey: MoviesEntity.id.rawValue) as! Int)
        clickedMovie.fullUrl = (movies![indexPath.row].value(forKey: MoviesEntity.posterPath.rawValue) as! String)
        clickedMovie.overview = (movies![indexPath.row].value(forKey: MoviesEntity.overview.rawValue) as! String)
        clickedMovie.releaseDate = (movies![indexPath.row].value(forKey: MoviesEntity.releaseDate.rawValue) as! String)
        clickedMovie.reviewURL = (movies![indexPath.row].value(forKey: MoviesEntity.reviewUrl.rawValue) as! String)
        clickedMovie.title = (movies![indexPath.row].value(forKey: MoviesEntity.title.rawValue) as! String)
        clickedMovie.trailerURL = (movies![indexPath.row].value(forKey: MoviesEntity.trailerUrl.rawValue) as! String)
        clickedMovie.voteAverage = (movies![indexPath.row].value(forKey: MoviesEntity.voteAverage.rawValue) as! Float)
        destinationVC.setMovie(movieObj: clickedMovie);
    }
    
}
