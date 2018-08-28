//
//  UIResponder.swift
//  cnotethegr8
//
//  Created by Corey Werner on 4/15/18.
//  Copyright © 2018 cnotethegr8. All rights reserved.
//

import UIKit

extension UIResponder {
    private weak static var currentFirstResponder: UIResponder? = nil
    
    static var current: UIResponder? {
        currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder), to: nil, from: nil, for: nil)
        return currentFirstResponder
    }
    
    @objc private func findFirstResponder() {
        UIResponder.currentFirstResponder = self
    }
}
