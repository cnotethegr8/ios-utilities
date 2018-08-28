//
//  ActionFeedbackGenerator.swift
//  cnotethegr8
//
//  Created by Corey Werner on 4/29/18.
//  Copyright © 2018 cnotethegr8. All rights reserved.
//

import UIKit
import AudioToolbox

enum ActionFeedbackType: Int {
    /// Weak boom
    case peek
    /// Strong boom
    case pop
    /// Series of three weak booms
    case nope
}

class ActionFeedbackGenerator: UIFeedbackGenerator {
    func actionOccurred(_ actionType: ActionFeedbackType) {
        switch actionType {
        case .peek:
            AudioServicesPlaySystemSound(1519)
        case .pop:
            AudioServicesPlaySystemSound(1520)
        case .nope:
            AudioServicesPlaySystemSound(UIDevice.current.hasTapticEngine ? 1521 : kSystemSoundID_Vibrate)
        }
    }
}
