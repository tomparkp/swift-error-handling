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
    typealias Response: JSONDecodable

    var method: HTTPMethod { get }
    var path: String { get }
}

extension TMDBRequest {
    var URLRequest: NSMutableURLRequest {
        let urlString = TMDB.baseURLString + path + "?api_key=\(TMDB.apiKey)"
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = method.rawValue

        return request
    }

    /// Throws TMDBClient.Error
    func parseResponse(data: NSData?, response: NSURLResponse?, error: NSError?) throws -> Self.Response {
        if let connectionError = error {
            throw TMDBClient.Error.ConnectionError(connectionError)
        }

        guard let urlResponse = response as? NSHTTPURLResponse else {
            throw TMDBClient.Error.MissingHTTPResponse
        }

        guard let responseData = data else {
            throw TMDBClient.Error.MissingResponseData
        }

        guard let json = try? JSON(data: responseData) else {
            throw TMDBClient.Error.JSONDeserializationFailed(responseData)
        }

        let responseCode = urlResponse.statusCode
        let successfulStatusCodes = Set(200..<300)

        guard successfulStatusCodes.contains(responseCode) else {
            if let errorCode = try? json.int("status_code"),
                let serverError = TMDB.Error(rawValue: errorCode) {
                    throw TMDBClient.Error.ServerError(serverError)
            } else {
                throw TMDBClient.Error.UnacceptableStatusCode(responseCode)
            }
        }

        do {
            let value = try Response(json: json)
            return value
        } catch let error {
            throw TMDBClient.Error.JSONMappingFailed(error as? JSON.Error)
        }
    }
}
