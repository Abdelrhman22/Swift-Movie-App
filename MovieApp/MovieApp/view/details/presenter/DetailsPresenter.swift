//
//  DetailsPresenter.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/13/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
class DetailsPresenter{
    var detailsDelegate : DetailsDelegate?
    var connection: NetworkProtocol?
    var MovieReviews : String = ""
    init()
    {
        connection = NetworkConnection()
    }
    func setDelegate(delegate: DetailsDelegate)
    {
        self.detailsDelegate = delegate
        self.connection?.setDelegate(delegate: self)
    }
    func getReviews(url : String) {
        connection?.getReviews(url: url)
    }
    func setReviews(str : String){
        //print("==========  Reviews in Presenter\(str)")
        detailsDelegate?.setReviews(reviewStr : str)
    }
}
