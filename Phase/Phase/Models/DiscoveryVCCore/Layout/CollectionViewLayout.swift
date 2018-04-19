//
//  CollectionViewLayout.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

protocol CollectionViewDelegateLayout: class {
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
}

class CollectionViewLayout: UICollectionViewFlowLayout {
    
    struct Configuration {
        var numberOfColumns: Int
        let minimumInterItemSpacing: CGFloat = 8
        let minimumLineSpacing: CGFloat = 8
        var sectionInsets = UIEdgeInsets(top: 4, left: 8, bottom: 16, right: 8) // CollectionView Insets
        
        init(numberOfColumns: Int) {
            self.numberOfColumns = numberOfColumns
        }
        var itemWidth: CGFloat {
            return (UIScreen.main.bounds.width - minimumLineSpacing - sectionInsets.left - sectionInsets.right) / CGFloat(numberOfColumns)
        }
        
        func itemHeight(rawItemSize: CGSize) -> CGFloat {
            let itemHeight = rawItemSize.height * itemWidth / rawItemSize.width
            return itemHeight
        }
    }
        
    var number = 1
    weak var delegate: CollectionViewDelegateLayout?
    private var configuration = Configuration(numberOfColumns: 0)
    private var columnContainer: ColumnContainer
    
    init(number: Int) {
        self.number = number
        self.configuration = Configuration(numberOfColumns: number)
        if number == 1 {
            configuration.sectionInsets.right = 0
        } else {
            configuration.sectionInsets.right = 8
        }
        columnContainer = ColumnContainer(number: number, configuration: configuration)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        columnContainer = ColumnContainer(number: 0, configuration: configuration)
        super.init(coder: aDecoder)
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        columnContainer.reset()
        
        let section = 0
        for item in (0..<collectionView.numberOfItems(inSection: 0)) {
            let indexPath = IndexPath(item: item, section: section)
            let itemSize = delegate?.sizeForItemAt(indexPath: indexPath) ?? CGSize.zero
            columnContainer.addAttributes(indexPath: indexPath, itemSize: itemSize)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return columnContainer.all.flatMap { $0.getAttributes(rect: rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return columnContainer.all.flatMap { $0.getAttributes(indexPath: indexPath) }.first
    }
    
    override var collectionViewContentSize: CGSize {
        let width = collectionView?.bounds.width ?? CGFloat.leastNormalMagnitude
        let height = columnContainer.bottom
        return CGSize(width: width, height: height)
    }
}
protocol CollectionViewDelegateLayout2: class {
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
}


