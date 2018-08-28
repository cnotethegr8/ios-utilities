//
//  UICollectionView.swift
//  cnotethegr8
//
//  Created by Corey Werner on 3/21/18.
//  Copyright © 2018 cnotethegr8. All rights reserved.
//

import UIKit

extension UICollectionView {
    func indexPath(for event: UIEvent) -> IndexPath? {
        if let location = event.allTouches?.first?.location(in: self) {
            return indexPathForItem(at: location)
        }
        return nil
    }
}
