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
    func setReviews(reviewArr : Array<Review>) {
        
       /* for i in 0..<reviewArr.count
        {
            print(reviewArr[i].author)
            print(reviewArr[i].content)
            print("----------------------------")
        }*/
       self.reviews = reviewArr
        
        self.setre(reviewArr : reviewArr)
        DispatchQueue.main.async{
            self.view.reloadInputViews()
        }
     /*  for i in 0..<reviews.count
        {
            print(reviews[i].author)
            print(reviews[i].content)
            print("----------------------------")
        }*/
    }
    
    
}
