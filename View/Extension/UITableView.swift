//
//  UITableView.swift
//  cnotethegr8
//
//  Created by Corey Werner on 3/20/18.
//  Copyright © 2018 cnotethegr8. All rights reserved.
//

import UIKit

extension UITableView {
    func indexPath(for event: UIEvent) -> IndexPath? {
        if let location = event.allTouches?.first?.location(in: self) {
            return indexPathForRow(at: location)
        }
        return nil
    }
}
