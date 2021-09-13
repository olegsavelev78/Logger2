//
//  PulseLogger.swift
//  campus-ios
//
//  Created by Nikita Abramenko on 03.08.2021.
//

import PulseUI
import UIKit
import Pulse
import Logging

public typealias UIEventSubtype = UIEvent.EventSubtype

extension UIWindow {
    override open func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        #if DEBUG
        guard let rootVC = self.rootViewController else { return }
        
        if (event!.type == .motion && event!.subtype == .motionShake),
           !(rootVC is PulseUI.MainViewController) {
            rootVC.present(PulseUI.MainViewController(), animated: true)
        } else {
            super.motionEnded(motion, with: event)
        }
        #endif
    }
}

final class PulseLogger: LoggerType {
    
    private var logger: Logging.Logger {
       return Logging.Logger(label: "\(Bundle.main.bundleIdentifier!)")
    }
    
    func log(_ level: LogLevel, tag: LogTag, className: String, _ message: String) {
        switch level {
        case .debug:
            logger.debug("🟢 DEBUG: \n[\(className)]\n\t -> \(message)")
        case .info:
            logger.info("🔵 INFO: \n[\(className)]\n\t -> \(message)")
        case .warning:
            logger.warning("🟡 WARNING: \n[\(className)]\n\t -> \(message)")
        case .error:
            logger.error("🔴 ERROR: \n[\(className)]\n\t -> \(message)")
        default:
            logger.notice("🟣 VERBOSE: \n[\(className)]\n\t -> \(message)")
        }
    }
}
