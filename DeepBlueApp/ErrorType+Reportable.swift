//
//  ErrorType+Reportable.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation
import Raven

/*
    The Reportable protocol provides a common interface for reporting
    errors to an error logging service like Sentry - http://getsentry.com
    
    Since we're using a protocol it's easy to swap out Sentry for other
    services. We just change our `report` function.

    This is the magic of protocol extensions - by extending our Reportable
    protocol we can provide all objects that conform to it with default
    functionality (that we can also override if neccessary).

    Macros like `__FUNCTION__` provide us with a string version of the
    current function, etc. so we can include them with our error report.
*/
protocol Reportable: ErrorType {
    var reportDescription: String { get }
    var reportLevel: ReportLevel { get }

    func report(function: String, file: String, line: Int)
}

enum ReportLevel {
    case None
    case Debug
    case Info
    case Warning
    case Error
    case Fatal
}

extension Reportable {
    func report(function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) {
        let sentry = RavenClient.sharedClient()
        var logLevel: RavenLogLevel

        switch reportLevel {
        case .None:
            return
        case .Debug:
            logLevel = kRavenLogLevelDebug
        case .Info:
            logLevel = kRavenLogLevelDebugInfo
        case .Warning:
            logLevel = kRavenLogLevelDebugWarning
        case .Error:
            logLevel = kRavenLogLevelDebugError
        case .Fatal:
            logLevel = kRavenLogLevelDebugFatal
        }

        sentry.captureMessage("\(reportDescription)", level: logLevel, method: function, file: file, line: line)
    }
}