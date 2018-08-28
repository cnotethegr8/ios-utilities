//
//  DynamicTypeAccessibilityLayout.swift
//  cnotethegr8
//
//  Created by Corey Werner on 3/28/18.
//  Copyright © 2018 cnotethegr8. All rights reserved.
//

import UIKit

/* Example:
 
 var fontSizeStandardRangeConstraints: [NSLayoutConstraint] = []
 var fontSizeAccessibilityRangeConstraints: [NSLayoutConstraint] = []
 
 override func viewDidLoad() {
    super.viewDidLoad()
 
    let view1 = UIView()
 
    fontSizeStandardRangeConstraints += [
        view1.topAnchor.constraint(equalTo: view.topAnchor)
    ]
 
    adjustDynamicTypeLayout(traitCollection: traitCollection)
 }
 
 override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
 
    adjustDynamicTypeLayout(traitCollection: traitCollection, previousTraitCollection: previousTraitCollection)
 }
 
 */

protocol DynamicTypeAccessibilityLayout {
    var fontSizeStandardRangeConstraints: [NSLayoutConstraint] { get set }
    var fontSizeAccessibilityRangeConstraints: [NSLayoutConstraint] { get set }
}

extension DynamicTypeAccessibilityLayout {
    private func adjustConstraints(with isAccessibilityCategory: Bool) {
        if isAccessibilityCategory {
            NSLayoutConstraint.deactivate(fontSizeStandardRangeConstraints)
            NSLayoutConstraint.activate(fontSizeAccessibilityRangeConstraints)
        }
        else {
            NSLayoutConstraint.deactivate(fontSizeAccessibilityRangeConstraints)
            NSLayoutConstraint.activate(fontSizeStandardRangeConstraints)
        }
    }
    
    func adjustDynamicTypeLayout(traitCollection: UITraitCollection) {
        adjustConstraints(with: traitCollection.preferredContentSizeCategory.isAccessibilityCategory)
    }
    
    func adjustDynamicTypeLayout(traitCollection: UITraitCollection, previousTraitCollection: UITraitCollection?) {
        guard let previousContentSizeCategory = previousTraitCollection?.preferredContentSizeCategory else {
            return
        }
        
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        
        if previousContentSizeCategory.isAccessibilityCategory != isAccessibilityCategory {
            adjustConstraints(with: isAccessibilityCategory)
        }
    }
}
