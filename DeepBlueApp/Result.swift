//
//  Result.swift
//  ErrorBoss
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation

/*
    The Result enum uses Generics to provide us with an easily reusable
    error handling mechanism. It's actually very similar to how Optionals
    are implemented under the hood in Swift.

    A Generic is essentially a placeholder for a type. In the case of
    Result we are defining two generic types: `T` which represents
    the type of value we'll have if the task is successful, and `E`
    which represents the type of error we'll have if it fails.

    Note that you can make a generic conform to specific types/protocols,
    for example we're stating that `E` will always be an `ErrorType`.

    This is very powerful, because it lets use reuse Result with any
    types we'd like. We don't have to make different results for cases
    where we return a String vs an Array for example - we can reuse
    this for everything.

    To use it in practice we would simply declare the type like so:
    `Result<String, APIError>`

    In that example we're saying that the `Success` case will have
    a String associated with it and the `Failure` case will have
    an APIError.

    The Result approach has several benefits over try-catch, the two
    most notable being:

    1. It works with asynchoronous operations (like network tasks)
    2. You can specify the type of error that will be returned, instead
       of having to cast and handle errors of types never returned.
*/
enum Result<T, E: ErrorType> {
    case Success(T)
    case Failure(E)
}