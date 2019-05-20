//
//  HomeCollectionViewController_ExtensionDelegate.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/13/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
import UIKit
extension HomeCollectionViewController: HomeDelegate
{
    func setPopularMovies(popularArr: Array<Movie>) {
        self.movies = popularArr
        DispatchQueue.main.async{
            self.collectionView?.reloadData()
        }
    }
    
    func errorPopularMovies() {
    self.errorInternetConnection()
    }
    
    
}
