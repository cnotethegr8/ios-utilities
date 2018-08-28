//
//  DataSource.swift
//  cnotethegr8
//
//  Created by Corey Werner on 7/10/18.
//  Copyright © 2018 cnotethegr8. All rights reserved.
//

import Foundation

/* Example:
 
 enum Section: Int {
    case firstSection
    case secondSection
 }
 
 enum Row: Int {
    case firstRow
    case secondRow
 }
 
 let dataSource = DataSource<Section, Row>(data: [:])
 
 */

class DataSource<S: RawRepresentable & Hashable, R: RawRepresentable & Equatable> {
    private var data: [(section: S, rows: [R])] = []
    
    init(data: [(S, [R])]) {
        data.forEach { (section, rows) in
            addSection(section, rows: rows)
        }
    }
    
    // MARK: Section
    
    var count: Int {
        return data.count
    }
    
    private func sectionIndex(_ section: S) -> Int? {
        return data.index(where: { $0.section == section })
    }
    
    func addSection(_ section: S, rows: [R], at index: Int = .max) {
        guard sectionIndex(section) == nil else {
            return
        }
        data.insert((section, rows), at: (index == .max) ? count : index)
    }
    
    func removeSection(_ section: S) {
        if let index = sectionIndex(section) {
            data.remove(at: index)
        }
    }
    
    func updateSection(_ section: S, rows: [R]) {
        guard let sectionIndex = sectionIndex(section) else {
            return
        }
        data[sectionIndex].rows = rows
    }
    
    func section(_ sectionIndex: Int) -> S? {
        guard data.count > sectionIndex else {
            return nil
        }
        return data[sectionIndex].section
    }
    
    // MARK: Row
    
    func rows(_ sectionIndex: Int) -> [R]? {
        guard data.count > sectionIndex else {
            return nil
        }
        return data[sectionIndex].rows
    }
    
    func row(_ indexPath: IndexPath) -> R? {
        guard data.count > indexPath.section else {
            return nil
        }
        let rows = data[indexPath.section].rows
        guard rows.count > indexPath.row else {
            return nil
        }
        return rows[indexPath.row]
    }
    
    func addRow(_ row: R, in section: S, at index: Int = .max) {
        guard let sectionIndex = sectionIndex(section) else {
            return
        }
        let rowsCount = data[sectionIndex].rows.count
        data[sectionIndex].rows.insert(row, at: (index == .max) ? rowsCount : index)
    }
    
    func removeRow(_ row: R, in section: S) {
        guard let sectionIndex = sectionIndex(section) else {
            return
        }
        if let rowIndex = data[sectionIndex].rows.index(of: row) {
            data[sectionIndex].rows.remove(at: rowIndex)
        }
    }
    
    // MARK: Index Path
    
    func indexPath(row: R, section: S) -> IndexPath? {
        guard let sectionIndex = sectionIndex(section),
            let rowIndex = data[sectionIndex].rows.index(where: { $0 == row })
            else {
                return nil
        }
        return IndexPath(row: rowIndex, section: sectionIndex)
    }
}
