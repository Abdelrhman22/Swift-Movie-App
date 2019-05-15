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
class MovieDetailsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    
    
    @IBOutlet var reviewTableView: UITableView!
    
    @IBOutlet var reviewTextView: UITextView!
    @IBOutlet var reviewsLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    var fullReviews : String = "Intial Value"
    var movies : [NSManagedObject]!;
    var reviews : [Review]!
    let dataLayer : DataLayer = DataLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    var myMovie : Movie = Movie ()
    var detailsPresenter : DetailsPresenter = DetailsPresenter()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.reviews = []
        
        
       //print("viewDidLoad count \(reviews.count)")
        titleLabel.text = myMovie.title
        yearLabel.text = myMovie.releaseDate
        rateLabel.text = String( myMovie.voteAverage ) + " /10"
        posterImageView.sd_setImage(with: URL(string: myMovie.fullUrl), placeholderImage: UIImage(named: "placeholder.jpg"))
        overviewLabel.text = myMovie.overview

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewTableView.dequeueReusableCell(withIdentifier:"reviewCell" , for: indexPath) as! TableViewCell
        
        cell.detailTextLabel?.text = "lkubgfg"
        
        
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
       // print("viewDidLoad count \(reviews.count)")

        DispatchQueue.main.async{
        
            for index in 0..<self.reviews.count
            {
            
                print("jfdalsdfbgalsiubf \(self.reviews.count)")
                print(self.reviews[index].author)
                print(self.reviews[index].content)
                print("-----------------------------")
               // var str = self.reviews[index].author
                //str.append("\n\(self.reviews[index].content)")
               // self.reviewTextView.text = self.reviews[index].author + self.reviews[index].content
            }
            self.view.reloadInputViews()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setMovie(movieObj : Movie)
        {
            myMovie = movieObj
            self.detailsPresenter.setDelegate(delegate: self)
            self.detailsPresenter.getReviews(url: self.myMovie.reviewURL)
            DispatchQueue.main.async{

            
            }

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
    func setre(reviewArr: Array<Review>)  {
        self.reviews = reviewArr
    }

}
