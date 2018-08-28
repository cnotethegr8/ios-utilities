//
//  UIDevice.swift
//  cnotethegr8
//
//  Created by Corey Werner on 10/3/17.
//  Copyright © 2017 cnotethegr8. All rights reserved.
//

import UIKit

// MARK: - Type

extension UIDevice {
    fileprivate var modelIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        return machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
    }
    
    fileprivate var modelIdentifierNumber: Double {
        // https://www.theiphonewiki.com/wiki/Models
        return Double(modelIdentifier.replacingOccurrences(of: ",", with: ".").trimmingCharacters(in: CharacterSet.decimalDigits.inverted)) ?? 0
    }
    
    // MARK: Characteristics
    
    var isHomeButtonless: Bool {
        guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.first else {
            return false
        }
        
        return window.safeAreaInsets.bottom > 0
    }
    
    var hasTapticEngine: Bool {
        return modelIdentifierNumber >= 8 // greater then iPhone 6s
    }
    
    // MARK: Model
    
    var isSimulator: Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
    }
    
    var isIphoneX: Bool {
        if UIDevice.isSimulator {
            return self.userInterfaceIdiom == .phone && UIDevice.is812h
        }
        else {
            return modelIdentifierNumber == 10.3 || modelIdentifierNumber == 10.6
        }
    }
}

// MARK: - Size

extension UIDevice {
    var is320w: Bool {
        return UIScreen.main.bounds.size.width == 320 // 4, 5
    }
    var is375w: Bool {
        return UIScreen.main.bounds.size.width == 375 // 6, 7, 8, X
    }
    var is414w: Bool {
        return UIScreen.main.bounds.size.width == 414 // 6+, 7+, 8+
    }
    
    var is480h: Bool {
        return UIScreen.main.bounds.size.height == 480 // 4
    }
    var is568h: Bool {
        return UIScreen.main.bounds.size.height == 568 // 5
    }
    var is667h: Bool {
        return UIScreen.main.bounds.size.height == 667 // 6, 7, 8
    }
    var is736h: Bool {
        return UIScreen.main.bounds.size.height == 736 // 6+, 7+, 8+
    }
    var is812h: Bool {
        return UIScreen.main.bounds.size.height == 812 // X
    }
}
