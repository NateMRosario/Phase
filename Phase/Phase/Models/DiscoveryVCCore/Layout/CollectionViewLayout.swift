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

class CollectionViewLayout: UICollectionViewLayout {
    
    struct Configuration {
        let numberOfColumns = 2
        let minimumInterItemSpacing: CGFloat = 8
        let minimumLineSpacing: CGFloat = 8
        let sectionInsets = UIEdgeInsets(top: 4, left: 8, bottom: 16, right: 8) // CollectionView Insets
        
        var itemWidth: CGFloat {
            return (UIScreen.main.bounds.width - minimumLineSpacing - sectionInsets.left - sectionInsets.right) / 2
        }
        
        func itemHeight(rawItemSize: CGSize) -> CGFloat {
            let itemHeight = rawItemSize.height * itemWidth / rawItemSize.width
            return itemHeight
        }
    }
    
    weak var delegate: CollectionViewDelegateLayout?
    private var configuration = Configuration()
    private var columnContainer: ColumnContainer
    
    override init() {
        columnContainer = ColumnContainer(configuration: configuration)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        columnContainer = ColumnContainer(configuration: configuration)
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
