//
//  NetworkProtocol.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/13/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
protocol NetworkProtocol {
    func fetchMostPopular(url : String) ;
    //func fetchTopRated(url : String) -> Array<Movie> ;
    func setDelegate(delegate: HomePresenter);

    
    
}