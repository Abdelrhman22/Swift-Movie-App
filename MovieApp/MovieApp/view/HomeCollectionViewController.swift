//
//  HomeCollectionViewController.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/11/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON
private let reuseIdentifier = "homeCollectionCell"

class HomeCollectionViewController: UICollectionViewController {
      var movies : [Movie]!;
      var arrRes = [[String:AnyObject]]() //Array of dictionary
      let dataLayer : DataLayer = DataLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.clearsSelectionOnViewWillAppear = false
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        movies = []
        DispatchQueue.main.async
            {
                Alamofire.request("https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=dc9a86621980e480855fa9b593c738e7").responseJSON { (responseData) -> Void in
                    if((responseData.result.value) != nil)
                    {
                        let swiftyJsonVar = JSON(responseData.result.value!)
                        if let resData = swiftyJsonVar["results"].arrayObject
                        {
                            self.arrRes = resData as! [[String:AnyObject]]
                            //print(self.arrRes)
                            for index in 0..<self.arrRes.count{
                                let dict = self.arrRes[index]
                                let movieObject = Movie()
                                let movieId = dict["id"] as! Int
                                movieObject.id = movieId
                                let imgUrl = dict["poster_path"] as? String
                                let fullUrl = "https://image.tmdb.org/t/p/w185/"+imgUrl!
                                movieObject.fullUrl = fullUrl
                                movieObject.title = (dict["title"] as? String)!
                                movieObject.overview = (dict["overview"]as? String)!
                                movieObject.releaseDate = (dict["release_date"]as? String)!
                                let reviewURL = "https://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=dc9a86621980e480855fa9b593c738e7"
                                movieObject.reviewURL = reviewURL
                                movieObject.voteAverage = (dict["vote_average"] as? NSNumber)?.floatValue ?? 0
                                self.dataLayer.printMovie(movie: movieObject)
                                self.movies.append(movieObject)
                                DispatchQueue.main.async
                                    {
                                         self.collectionView?.reloadData()
                                }
                                //let saveStatus = self.dataLayer.insertMovie(movie: movieObject)
                                //print("saveStatus\(saveStatus)")
                            }
                        }
                        else
                        {
                            print("responseData No results")
                        }
                    } // end of If
                    else
                    {
                        print("responseData is nil")
                    }
                    
                } // end of Alamofire.request
        } // end of DispatchQueue
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        let image = movies[indexPath.row].fullUrl
        cell.moviePosterImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder.jpg"))
        // Configure the cell
    
        return cell
    }
    // Set two cells per row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 8 * 2) / 2 //some width
        let height = width * 275 / 185 //ratio
        return CGSize(width: width, height: height)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
