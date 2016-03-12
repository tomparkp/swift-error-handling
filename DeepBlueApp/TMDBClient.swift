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
    // In a production app you'll probably want to do some of your own configuration of NSURLSession
    // but we'll stick with the default here.
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

    // We can use Generics to create a placeholder for a type conforming to TMDBRequest
    // This is what lets us infer the type we want for our successful response value
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
                // An annoyance with try-catch is that you can't specify the type of error being
                // thrown, so we need to add this catch-all even though we only ever throw
                // TMDBClient.Error
                result = .Failure(.UnhandledError)
            }

            // Don't forget to get back on the main thread aftering performing the 
            // network request in the background.
            dispatch_async(dispatch_get_main_queue()) {
                completion(result: result)
            }
        }

        task.resume()
    }
}

