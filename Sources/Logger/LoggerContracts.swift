//
//  LoggerContracts.swift
//  campus-ios
//
//  Created by Vladimir Golovkin on 06.09.2021.
//

import Foundation

public enum LogTag: String {
    case unnamed
    case observable
    case model
    case viewModel
    case view
    case service
    case repository
    case presenter
}

public enum LogLevel: Int {
    case verbose = 0
    case debug = 1
    case info = 2
    case warning = 3
    case error = 4
}

// MARK: Logger type
/// Protocol for custom logger which should be registered
public protocol LoggerType {
    func log(_ level: LogLevel, tag: LogTag, className: String, _ message: String)
}

// MARK: Loggable
/// Protocol for models which are logging data
public protocol Loggable {
    var loggingTag: LogTag { get }

    func log(_ level: LogLevel, _ message: String)
    func log(_ loggerType: LoggerRegisterType, _ level: LogLevel, _ message: String)
    func log(_ loggerType: LoggerRegisterType, _ level: LogLevel, tag: LogTag, _ message: String)
}

public extension Loggable {
    
    var loggingTag: LogTag {
        return .unnamed
    }
    
    func log(_ level: LogLevel, _ message: String) {
        self.log(.simple, level, tag: loggingTag, message)
    }
    
    func log(_ loggerType: LoggerRegisterType, _ level: LogLevel, _ message: String) {
        self.log(loggerType, level, tag: loggingTag, message)
    }
    
    func log(_ loggerType: LoggerRegisterType, _ level: LogLevel, tag: LogTag, _ message: String) {
        Logger.sharedInstance.log(loggerType, level, tag: tag, className: String(describing: type(of: self)), message)
    }
}

open class Loggable2: Loggable {
    init() { }
}
