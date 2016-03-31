//
//  TMDB.swift
//  ErrorBoss
//
//  Created by Tom Piarulli on 2/8/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation
import Freddy

protocol TMDBRequest {
    // This allows us to provide a type to use when mapping
    // the JSON to a strongly typed object.
    associatedtype Response: JSONDecodable

    var method: HTTPMethod { get }
    var path: String { get }
    var URLRequest: NSMutableURLRequest { get }
    var successfulStatusCodes: Set<Int> { get }

    func errorForResponse(response: NSHTTPURLResponse, data: NSData?) -> TMDBClient.Error
    func parseResponse(data: NSData?, response: NSURLResponse?, error: NSError?) throws -> Self.Response
}

extension TMDBRequest {
    // We can use a protocol extension to give all of our API requests the ability to
    // generate an NSURLRequest for use by NSURLSession
    var URLRequest: NSMutableURLRequest {
        let urlString = TMDB.baseURLString + path + "?api_key=\(TMDB.apiKey)"
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = method.rawValue

        return request
    }

    // By default we'll check for 2XX as success codes from the server.
    // By separating this into its own property we can override it for
    // a specific request if neccessary.
    var successfulStatusCodes: Set<Int> {
        return Set(200..<300)
    }

    /*
        This is a great example of our protocol extensions can provide shared functionality
        while remaining flexible. In the case of the TMDB API every error provides
        a unique status code, but what if that wasn't the case and you wanted to provide
        different errors based on the request you were making?
    
        For example - if the server returns a 404 from my login endpoint maybe I want to
        return a UserNotFound error, but if it returns a 404 from my movie endpoint I want
        to return a MovieNotFound error. All I need to do is override this method for
        the individual request.
    */
    func errorForResponse(response: NSHTTPURLResponse, data: NSData?) -> TMDBClient.Error {
        if let data = data,
            let json = try? JSON(data: data),
            let code = try? json.int("status_code"),
            let error = TMDB.Error(rawValue: code) {
                return .ServerError(error)
        }

        return .UnacceptableStatusCode(response.statusCode)
    }

    /*
        We can encapsulate the logic for parsing an API response within the request object.
        This makes it easy to customize how we respond to various API requests.
    
        For example we can individually override what status codes are considered successful,
        which error should be returned, and what strongly typed object should be returned
        if the request succeeds.
    */
    func parseResponse(data: NSData?, response: NSURLResponse?, error: NSError?) throws -> Self.Response {
        if let connectionError = error {
            throw TMDBClient.Error.ConnectionError(connectionError)
        }

        guard let urlResponse = response as? NSHTTPURLResponse else {
            throw TMDBClient.Error.MissingHTTPResponse
        }

        guard successfulStatusCodes.contains(urlResponse.statusCode) else {
            throw errorForResponse(urlResponse, data: data)
        }

        guard let responseData = data else {
            throw TMDBClient.Error.MissingResponseData
        }

        guard let json = try? JSON(data: responseData) else {
            throw TMDBClient.Error.JSONDeserializationFailed(responseData)
        }

        /*
            Note how we can map to our generic Response object since we've made
            it conform to JSONDecodable. This is what makes our movie request
            return a `Movie` object.
        
            It should be noted that for the sake of simplicity I've assumed the
            API is always going to be returning a JSON response. In a real application
            you'll probably want to separate this into its own function so you can override
            how individual requests parse their responses.
        
            Hint: Did you know you can even scope protocol extensions? 
        
            For example:
        
            extension TMDBRequest where Response: JSONDecodable {
                // I can provide special functionality for when our response object is
                // JSONDecodable! How cool is that?
            }
        */
        do {
            let value = try Response(json: json)
            return value
        } catch let error {
            throw TMDBClient.Error.JSONMappingFailed(error as? JSON.Error)
        }
    }
}


