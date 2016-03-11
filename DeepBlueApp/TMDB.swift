//
//  TMDB.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation

/* 
    I'm using a TMDB struct with static properties for accessing
    small shared variables easily i.e. `TMDB.apiKey`.
*/
struct TMDB {
    static let baseURLString = "https://api.themoviedb.org/3"
    static let apiKey = "8a4a247d072d9ca4a0072893ab60e277"
}

/*
    Swift has pseudo-namespacing by allowing you to embed certain
    objects within eachother. This provides us with the following
    syntax: `TMDB.Error.InvalidAPIKey`.

    You don't have to do this. There isn't anything wrong with
    simply calling it TMDBError and not nesting it.

    By making the backing type of the error an Int we can map
    it directly to error codes from the TMDB API:
    https://www.themoviedb.org/documentation/api/status-codes

    The extension here is just to break things up - you could
    keep it all in the main definition if you wanted to.
*/
extension TMDB {
    enum Error: Int, ErrorType {
        case InvalidService = 2
        case InvalidPermissions = 3
        case InvalidFormat = 4
        case InvalidParameters = 5
        case InvalidId = 6
        case InvalidAPIKey = 7
        case DuplicateEntry = 8
        case ServiceOffline = 9
        case SuspendedAPIKey = 10
        case InternalError = 11
        case AuthenticationFailed = 14
        case Failed = 15
        case DeviceDenied = 16
        case SessionDenied = 17
        case ValidationFailed = 18
        case InvalidAcceptHeader = 19
        case InvalidDateRange = 20
        case EntryNotFound = 21
        case InvalidPage = 22
        case InvalidDate = 23
        case TimedOut = 24
        case RequestLimitReached = 25
        case MissingCredentials = 26
        case TooManyAppends = 27
        case InvalidTimezone = 28
        case ConfirmationRequired = 29
        case InvalidCredentials = 30
        case AccountDisabled = 31
        case EmailNotVerified = 32
        case InvalidRequestToken = 33
        case ResourceNotFound = 34
    }
}
