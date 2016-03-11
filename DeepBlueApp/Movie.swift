//
//  Movie.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation
import Freddy

/*
    All we need to do to make our model objects automagically parsable
    from the TMDB API is to have them conform to the JSONDecodable
    protocol.

    Freddy provides us with the JSONDecodable protocol and JSON object
    for easy JSON parsing, but we could also implement our own
    JSONDecodable protocol and use it without changing much in the
    rest of our project (aren't protocols great?).
*/
struct Movie: JSONDecodable {
    let title: String
    let overview: String

    init(json: JSON) throws {
        title = try json.string("title")
        overview = try json.string("overview")
    }
}

