//
//  TMDB+MovieRequest.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation

/*
    Since our TMDBRequest protocol includes all of the functionality
    for generating API requests we just need to conform to it
    and provide some basic information about the request like path,
    method, and response type.

    In order to add another request we just create another request
    object that conforms to the TMDBRequest protocol.
*/
struct TMDBMovieRequest: TMDBRequest {
    let id: Int

    typealias Response = Movie

    var path: String {
        return "/movie/\(id)"
    }

    var method: HTTPMethod {
        return .GET
    }
}

/*
    You might be wondering why we don't use an enum for our API requests.

    A lot of libraries like Moya and Alamofire recommend an approach like
    the one shown below:

    enum TMDBRequest {
    case Movie(id: Int)

        var path: String {
            switch self {
            case .Movie(let id):
                return "/movie/\(id)"
            }
        }

        var method: HTTPMethod {
            switch self {
            case .Movie:
                return .GET
            }
        }
    }

    This approach is great and I started with it myself. However there are
    a few issues I encountered with it:

    1. Once your API grows beyond trivial you end up with a pretty large
       enum declaration - to a point that it becomes unwieldy and difficult
       to maintain.

    2. Due to the nature of enums when dealing with a large API you'd have no
       choice but to break up the functionality in a way that isn't particularly
       intuitive (one file for paths, one file for methods, etc.) I find it
       easier to understand when things are broken up by request.

    3. Since you're using switches it becomes tempting to define default cases
       for things like method. At first this is great, but once your API grows
       large enough it's difficult to see whether you've implemented all
       of the cases you need to. If you miss a case the compiler won't warn you,
       instead it will fall back to the default case which may not be what you
       expect.

    4. Using individual objects for requests lets us use a typealias to specify
       the type of object we want back from our request. This lets us encapsulate
       the actual mapping of an API response to a strongly typed object within
       our API request function, saving us the extra step of mapping it manually
       for each request.
*/

