//
//  Movie.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation
import Freddy

struct Movie: JSONDecodable {
    let title: String
    let overview: String

    init(json: JSON) throws {
        title = try json.string("title")
        overview = try json.string("overview")
    }
}