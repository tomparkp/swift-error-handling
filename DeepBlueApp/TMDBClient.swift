//
//  TMDBClient.swift
//  ErrorBoss
//
//  Created by Tom Piarulli on 2/8/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation
import Freddy

class TMDBClient {
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

    func request<T: TMDBRequest>(request: T, completion: (result: Result<T.Response, TMDBClient.Error>) -> Void) {
        print("Requesting \(request.path)")

        let task = session.dataTaskWithRequest(request.URLRequest) { (data, response, error) in
            var result: Result<T.Response, TMDBClient.Error>

            do {
                let value = try request.parseResponse(data, response: response, error: error)
                result = .Success(value)
            } catch let error as TMDBClient.Error {
                result = .Failure(error)
            } catch {
                result = .Failure(.UnhandledError)
            }

            dispatch_async(dispatch_get_main_queue()) {
                completion(result: result)
            }
        }

        task.resume()
    }
}

