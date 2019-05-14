//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/11/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SDWebImage
class MovieDetailsViewController: UIViewController {
    
    @IBOutlet var reviewsLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    var movies : [NSManagedObject]!;
    let dataLayer : DataLayer = DataLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    var myMovie : Movie = Movie ()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        titleLabel.text = myMovie.title
        yearLabel.text = myMovie.releaseDate
        rateLabel.text = String( myMovie.voteAverage ) + " /10"
        posterImageView.sd_setImage(with: URL(string: myMovie.fullUrl), placeholderImage: UIImage(named: "placeholder.jpg"))
        overviewLabel.text = myMovie.overview
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setMovie(movieObj : Movie)
        {
            myMovie = movieObj
            dataLayer.printMovie(movie: myMovie)
    }
    @IBAction func addToFavourite(_ sender: UIButton) {
        //print("Button Fav Clicked")
        let ismovieExist = dataLayer.isMovieExists(id: myMovie.id)
        if ismovieExist
        {
            print("This Movie Already in Favouroties")
        }
        else{
            let addStatus = dataLayer.insertMovie(movie: myMovie)
            print("Movie added Status \(addStatus)")
        }
    }
    /*ß 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
