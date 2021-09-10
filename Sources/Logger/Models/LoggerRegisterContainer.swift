//
//  LoggerRegisterContainer.swift
//  campus-ios
//
//  Created by Vladimir Golovkin on 06.09.2021.
//

import Foundation

public enum LoggerRegisterType {
    case simple, pulse
    
    func fetchLogger() -> LoggerType? {
        switch self {
        case .simple:
            return SimpleLogger()
        case .pulse:
            return PulseLogger()
        }
    }
}

public struct LoggerRegisterContainer {
    let type: LoggerRegisterType
    private(set) var logger: LoggerType?
    
    init(_ type: LoggerRegisterType) {
        self.type = type
        logger = type.fetchLogger()
    }
}
