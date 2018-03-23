//
//  CarouselFlowLayout.swift
//  Phase
//
//  Created by Clint Mejia on 3/23/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class CarouselFlowLayout: UICollectionViewFlowLayout {
    
    var standardItemAlpha: CGFloat = 0.5
    var standardItemScale: CGFloat = 0.5
    
    var isSetup = false
    
    override func prepare() {
        super.prepare()
        if isSetup == false {
            setupCollectionView()
            isSetup = true
        }
    }
    
    // calling the changelayoutAttributes functions by overriding layoutAttributesForElements
    // we get the default attributes by calling super
    // then we create a new array to hold our modified attributes
    // next we step through our array of attributes
    // to avoid any memory issues first make a copy of the attributes before we modify them
    // finally we call the helper method to modify the attributes and add them to the
    // attributes copy
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var attributesCopy = [UICollectionViewLayoutAttributes]()
        
        for itemAttributes in attributes! {
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            changeLayoutAttributes(itemAttributesCopy)
            
            attributesCopy.append(itemAttributesCopy)
        }
        
        return attributesCopy
    }
    
    // by selecting true we are telling the collectionViewLayout to refresh itself when scrolling
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    // Helper method to modify attributes
    func changeLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        
        // grabs vertical collectionView center and normalizes it by taking it's content offset
        // calculates the maximum distance between the items's height
        let collectionCenter = collectionView!.frame.size.height/2
        let offset = collectionView!.contentOffset.y
        let normalizedCenter = attributes.center.y - offset
        
        // find the vertical distance subtracting the normalized center from the view's center and comparing it to the max distance and taking the lesser of the two values
        let maxDistance = self.itemSize.height + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        
        // ratio is calculated using the distance and max distance
        let ratio = (maxDistance - distance)/maxDistance
        
        // ratio is then used to calculate the alpha and scale values
        let alpha = ratio * (1 - self.standardItemAlpha) + self.standardItemAlpha
        let scale = ratio * (1 - self.standardItemScale) + self.standardItemScale
        
        // lastly the alpha is applied to layouts alpha property
        // and the attribute is scaled by applying a scale transform
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        
        //specifies the item's position on the z index
        attributes.zIndex = Int(alpha * 10)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let layoutAttributes = self.layoutAttributesForElements(in: collectionView!.bounds)
        
        let center = collectionView!.bounds.size.height / 2
        let proposedContentOffsetCenterOrigin = proposedContentOffset.y + center
        
        let closest = layoutAttributes!.sorted { abs($0.center.y - proposedContentOffsetCenterOrigin) < abs($1.center.y - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
        
        let targetContentOffset = CGPoint(x: proposedContentOffset.x, y: floor(closest.center.y - center))
        
        return targetContentOffset
    }
    
    func setupCollectionView() {
        self.collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
        
        let collectionSize = collectionView!.bounds.size
        let yInset = (collectionSize.height - self.itemSize.height) / 2
        let xInset = (collectionSize.width - self.itemSize.width) / 2
        
        self.sectionInset = UIEdgeInsetsMake(yInset, xInset, yInset, xInset)
        
    }
}


