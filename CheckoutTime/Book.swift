//
//  Book.swift
//  CheckoutTime
//
//  Created by Melissa  Garrett on 11/12/18.
//  Copyright © 2018 MelissaGarrett. All rights reserved.
//

import Foundation

class Book : NSObject {
    var title: String
    var author: String
    var genre: Genre
    
    init(title: String, author: String, genre: Genre) {
        self.title = title
        self.author = author
        self.genre = genre
    }    
}
