//
//  Genre.swift
//  CheckoutTime
//
//  Created by Melissa  Garrett on 11/12/18.
//  Copyright © 2018 MelissaGarrett. All rights reserved.
//

import Foundation

enum Genre: String, CaseIterable, Codable {
    case Financial = "FINANCIAL"
    case Inspirational = "INSPIRATIONAL"
    case Fictional = "FICTIONAL"
    case NonFictional = "NONFICTIONAL"
    case AutoBiographical = "AUTOBIOGRAPHICAL"
}

