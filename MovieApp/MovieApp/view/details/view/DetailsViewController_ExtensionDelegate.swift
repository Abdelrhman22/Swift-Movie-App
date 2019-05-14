//
//  DetailsViewController_ExtensionDelegate.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/13/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import Foundation
extension MovieDetailsViewController: DetailsDelegate
{
    func setReviews(reviewStr: String) {
       self.fullReviews = reviewStr
        DispatchQueue.main.async{
            self.view.reloadInputViews()
        }
        print("************ inside Extenstion *****\(fullReviews)")
    }
    
    
}
