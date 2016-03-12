//
//  TMDBClient+Error.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation
import Freddy

/*
    Since enums can have associated values in Swift, we can build
    a hierarchy of errors. For example - the JSONMappingFailed error
    includes a JSON.Error that can give us a more specific error
    regarding what key failed.
*/
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

/*
    Conforming to CustomStringConvertible lets us easily print errors to
    the console. I recommend using a logging framework like XCGLogger
    or SwiftyBeaver in a production app.
*/
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

/*
    One of the great things about enums and protocol extensions is you can easily
    organize your error handling by how it impacts the user.

    In this case if there is a connection issue we ask the user to check their
    connection. If it's any other TMDBClient Error (all things out of the user's
    control) we display a message saying something went wrong on our end.
*/
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

/*
    Conforming to the Reportable protocol is as simple as providing a description
    and a log level, everything else is contained within the protocol extension.

    By conforming to Reportable we can report errors to Sentry with one line:
    error.report()
*/
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