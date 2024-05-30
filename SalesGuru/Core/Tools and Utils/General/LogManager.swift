//
//  LogManager.swift
//  Pirelly
//
//  Created by shndrs on 7/25/23.
//

import Foundation
import FirebaseCrashlytics
import os
import Mixpanel

enum LogLevel: String {
    case error = "❌❌ Error", success = "✅✅ Success", info = "✏️✏️ Info", warning = "⚠️ ⚠️ Warning"
}

struct Logger {
    static let logger = OSLog(subsystem: "sales.guru.ios.App", category: "CustomLogs")
    static let userManager: UserManager = inject()
    
    static func log(_ level: LogLevel = .info, file: String = #file, function: String = #function, line: Int = #line, _ messages: Any...) {
         // Construct log message with source location information
         let filePart = file.components(separatedBy: "/").last ?? ""
         let logMessage = "[\(level.rawValue) >>>> on \(filePart) -> \(function) line \(line)"

         // Append the variadic messages to the log message
         let formattedMessage = messages.map { String(describing: $0) }.joined(separator: " + ")

         // Combine source location information and messages
        let finalMessage = logMessage + " msg: " + formattedMessage + "]"

        // Log to NSLog for local debugging
        print(finalMessage)
        
        // mixPanel
#if DEBUG
#else
//        Mixpanel.getInstance(name: "Logger")?.trackWithGroups(event: "Log", properties: [
//            "email": userManager.email ?? "",
//            "uid": userManager.uid ?? "",
//            "event Type": level.rawValue,
//            "message": finalMessage
//        ], groups: nil)
#endif
        
        // Log to Firebase Crashlytics for remote monitoring
        switch level {
        case .error:
//            os_log("%{public}s", log: logger, type: .error, finalMessage)
            Crashlytics.crashlytics().record(error: NSError(domain: "AppError", code: 0, userInfo: [NSLocalizedDescriptionKey: finalMessage]))
        case .success, .warning, .info:
//            os_log("%{public}s", log: logger, type: .info, finalMessage)
            Crashlytics.crashlytics().log(finalMessage)
        }
    }
}
