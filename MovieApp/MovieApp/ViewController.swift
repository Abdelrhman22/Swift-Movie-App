//
//  ViewController.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/10/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON
class ViewController: UIViewController {
    let baseURL = "https://api.themoviedb.org"
    let apiKey = "dc9a86621980e480855fa9b593c738e7"
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    
    //  let dataLayer : DataLayer = DataLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    let dataLayer : DataLayer = DataLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    override func viewDidLoad() {
        super.viewDidLoad()
        print("******** viewDidLoad ********")
        DispatchQueue.main.async
            {
                Alamofire.request("https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=dc9a86621980e480855fa9b593c738e7").responseJSON { (responseData) -> Void in
                    if((responseData.result.value) != nil)
                    {
                        //print(responseData.result.value ?? "Empty")
                        //print("responseData")
                        let swiftyJsonVar = JSON(responseData.result.value!)
                        //print(swiftyJsonVar)
                        if let resData = swiftyJsonVar["results"].arrayObject
                        {
                            //print("responseData found results")
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
    } // end of viewDidLoad

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

