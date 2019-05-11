//
//  DataLayer.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/10/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
import CoreData

class DataLayer{

    let appDelegate : AppDelegate?
    let managedContext : NSManagedObjectContext?
    let movieEntity : NSEntityDescription?
    
    init(appDelegate : AppDelegate)
    {
        self.appDelegate = appDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        movieEntity = NSEntityDescription.entity(forEntityName: MoviesEntity.entityName.rawValue, in: managedContext!)
    }
    // method to insert Movie in CoreData
    func insertMovie(movie : Movie) -> Bool {
        
        let movieObj = NSManagedObject(entity: movieEntity!, insertInto: managedContext)
        
        movieObj.setValue(movie.id, forKey: MoviesEntity.id.rawValue)
        movieObj.setValue(movie.fullUrl, forKey: MoviesEntity.posterPath.rawValue)
        movieObj.setValue(movie.fullUrl, forKey: MoviesEntity.backdropPath.rawValue)
        movieObj.setValue(movie.title, forKey: MoviesEntity.title.rawValue)
        movieObj.setValue(movie.overview, forKey: MoviesEntity.overview.rawValue)
        movieObj.setValue(movie.releaseDate, forKey: MoviesEntity.releaseDate.rawValue)
        movieObj.setValue(movie.reviewURL, forKey: MoviesEntity.reviewUrl.rawValue)
        movieObj.setValue(movie.voteAverage, forKey: MoviesEntity.voteAverage.rawValue)
        
        print("Added to CoreData!")
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print(error)
            return false
        }
        return true
    }
    //*****************************************************************************************
    func printMovie(movie : Movie)-> Void
    {
     print("MovieID is \(movie.id)")
     print("MovieImg is \(movie.fullUrl)")
     print("title is \(movie.title)")
     print("overview is \(movie.overview)") 
     print("releaseDate is \(movie.releaseDate)")
     print("reviewURL is \(movie.reviewURL)")
     print("voteAverage is \(movie.voteAverage)")
     print("------------------------------------------")
    }
    //******************************************************************************************
}
