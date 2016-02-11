//
//  Result.swift
//  ErrorBoss
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation

enum Result<T, E: ErrorType> {
    case Success(T)
    case Failure(E)
}