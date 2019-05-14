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
    }
    func getReviews(url : String) {
        MovieReviews = (connection?.getReviews(url: url))!
        print("inside Presenter\(url)")
        detailsDelegate?.getReviews(reviewStr: MovieReviews)
    }
}
