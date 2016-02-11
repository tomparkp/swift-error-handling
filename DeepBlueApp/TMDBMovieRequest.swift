//
//  TMDB+MovieRequest.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation

struct TMDBMovieRequest: TMDBRequest {
    let id: Int

    typealias Response = Movie

    var method: HTTPMethod {
        return .GET
    }

    var path: String {
        return "/movie/\(id)"
    }
}