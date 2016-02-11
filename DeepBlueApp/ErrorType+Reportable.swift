//
//  ErrorType+Reportable.swift
//  DeepBlueApp
//
//  Created by Tom Piarulli on 2/11/16.
//  Copyright © 2016 Tom Piarulli. All rights reserved.
//

import Foundation
import Raven

enum ReportLevel {
    case None
    case Debug
    case Info
    case Warning
    case Error
    case Fatal
}

protocol Reportable {
    var reportDescription: String { get }
    var reportLevel: ReportLevel { get }
    func report(function: String, file: String, line: Int)
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