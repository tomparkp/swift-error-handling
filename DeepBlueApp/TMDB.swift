//
//  TMDB.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation

struct TMDB {
    static let baseURLString = "https://api.themoviedb.org/3"
    static let apiKey = "8a4a247d072d9ca4a0072893ab60e277"
}

extension TMDB {
    enum Error: Int, ErrorType {
        case InvalidService = 2
        case InvalidPermissions
        case InvalidFormat
        case InvalidParameters
        case InvalidId
        case InvalidAPIKey
        case DuplicateEntry
        case ServiceOffline
        case SuspendedAPIKey
        case InternalError
        case AuthenticationFailed = 14
        case Failed
        case DeviceDenied
        case SessionDenied
        case ValidationFailed
        case InvalidAcceptHeader
        case InvalidDateRange
        case EntryNotFound
        case InvalidPage
        case InvalidDate
        case TimedOut
        case RequestLimitReached
        case MissingCredentials
        case TooManyAppends
        case InvalidTimezone
        case ConfirmationRequired
        case InvalidCredentials
        case AccountDisabled
        case EmailNotVerified
        case InvalidRequestToken
        case ResourceNotFound
    }
}
