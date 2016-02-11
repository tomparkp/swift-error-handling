//
//  TMDBClient+Error.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation
import Freddy

extension TMDBClient {
    enum Error: ErrorType {
        case ConnectionError(NSError)
        case UnacceptableStatusCode(Int)
        case ServerError(TMDB.Error)
        case MissingHTTPResponse
        case MissingResponseData
        case JSONDeserializationFailed(NSData)
        case JSONMappingFailed(JSON.Error?)
        case UnhandledError
    }
}

extension TMDBClient.Error: CustomStringConvertible {
    var description: String {
        switch self {
        case .ConnectionError(let error):
            return "Connection Error: \(error.localizedDescription)"
        case .JSONDeserializationFailed:
            return "JSON Deserialization Failed"
        case .JSONMappingFailed(let error):
            return "JSON Mapping Failed: \(error)"
        case .MissingHTTPResponse:
            return "Missing HTTP Response"
        case .MissingResponseData:
            return "Missing Response Data"
        case .UnacceptableStatusCode(let code):
            return "Unacceptable Status Code: \(code)"
        case .ServerError(let error):
            return "Server Error: \(error)"
        case .UnhandledError:
            return "Unhandled Error"
        }
    }
}

extension TMDBClient.Error: AlertPresentable {
    var alertContent: (title: String, description: String) {
        var title: String
        var description: String

        switch self {
        case .ConnectionError:
            title = "Connection Issue"
            description = "There was problem with your connection, please try again."
        default:
            title = "Sorry"
            description = "Something went wrong on our end. It has been automatically reported and we're hard at work on it!"
        }

        return (title, description)
    }
}

extension TMDBClient.Error: Reportable {
    var reportDescription: String {
        return description
    }

    var reportLevel: ReportLevel {
        switch self {
        case .ConnectionError:
            return .Warning
        default:
            return .Error
        }
    }
}