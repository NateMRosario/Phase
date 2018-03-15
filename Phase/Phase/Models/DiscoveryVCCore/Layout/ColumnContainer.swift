//
//  ColumnContainer.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class ColumnContainer {
    private var columns = [Column]()
    private var configuration: CollectionViewLayout.Configuration
    
    init(configuration: CollectionViewLayout.Configuration) {
        self.configuration = configuration
        columns = [Column]()
        (0..<configuration.numberOfColumns).forEach{
            let column = Column(configuration: configuration, columnNumber: $0)
            self.columns.append(column)
        }
    }
    
    var bottom: CGFloat {
        let bottomItem = columns.sorted { $0.maxY < $1.maxY }.last
        if let maxY = bottomItem?.maxY {
            return maxY + configuration.sectionInsets.bottom
        } else {
            return CGFloat.leastNormalMagnitude
        }
    }
    
    var all: [Column] {
        return columns
    }
    
    var next: Column? {
        let sortedColumns = columns.sorted { $0.maxY < $1.maxY }
        return sortedColumns.first
    }
    
    public func reset() {
        let count = columns.count
        columns = [Column]()
        (0..<count).forEach{
            let column = Column(configuration: configuration, columnNumber: $0)
            self.columns.append(column)
        }
    }
    
    public func addAttributes(indexPath: IndexPath, itemSize: CGSize) {
        next?.addAttributes(indexPath: indexPath, itemSize: itemSize)
    }
}
