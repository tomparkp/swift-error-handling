//
//  HTTPMethod.swift
//  ErrorBoss
//
//  Created by Tom Piarulli on 2/8/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation

/*
    When configuring an NSURLRequest with Cocoa it takes in
    the HTTPMethod as a string i.e. "GET". Since using strings
    as type representations is bad practice we can create
    an enum with a raw type of String.

    This will allow us to use the safer enum syntax i.e. 
    `HTTPMethod.GET` while keeping it easily convertible to
    a String.

    By default in Swift an enum with a String as the raw type
    will have a raw value of the case name as a String. For
    example `HTTPMethod.GET.rawValue` will give us "GET".
*/
enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}