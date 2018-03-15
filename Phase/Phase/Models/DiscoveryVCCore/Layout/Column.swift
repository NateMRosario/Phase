//
//  Column.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class Column {
    private let configuration: CollectionViewLayout.Configuration
    private let columnNumber: Int
    private var attributesSet = [UICollectionViewLayoutAttributes]()
    private(set) var maxY: CGFloat = 0.0
    
    init(configuration: CollectionViewLayout.Configuration, columnNumber: Int) {
        self.configuration = configuration
        self.columnNumber = columnNumber
    }
    
    private var originX: CGFloat {
        var x = configuration.sectionInsets.left
        if columnNumber != 0 {
            x += (configuration.itemWidth + configuration.minimumLineSpacing) * CGFloat(columnNumber)
        }
        return x
    }
    
    private var originY: CGFloat {
        return (attributesSet.count == 0) ? configuration.sectionInsets.top : maxY + configuration.minimumLineSpacing
    }
    
    func addAttributes(indexPath: IndexPath, itemSize: CGSize) {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = CGRect(x: originX, y: originY, width: configuration.itemWidth, height: configuration.itemHeight(rawItemSize: itemSize))
        maxY = attributes.frame.maxY
        attributesSet.append(attributes)
    }
    
    func getAttributes(indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesSet.filter { $0.indexPath.section == indexPath.section && $0.indexPath.item == indexPath.item }.first
    }
    
    func getAttributes(rect: CGRect) -> [UICollectionViewLayoutAttributes] {
        return attributesSet.filter { $0.frame.intersects(rect) }
    }
}
