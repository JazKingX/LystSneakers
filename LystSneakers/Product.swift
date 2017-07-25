//
//  Sneaker.swift
//  LystSneakers
//
//  Created by Jaz King on 24/07/2017.
//  Copyright © 2017 Jaz King. All rights reserved.
//

import Foundation
import UIKit

class Product {
    
    let title: String
    let designerName: String
    let desginerSlug: String
    let discount: String
    let price: String
    let salePrice: String
    let slug: String
    let inStock: Bool
    let isIcon: Bool
    let onSale: Bool
    let freeShipping: Bool
    let isPinned: Bool
    let imageUrl: String
    
    init(title : String, designerName: String, designerSlug: String, price: String, onSale: Bool, salePrice: String, slug: String, discount: String, freeShipping: Bool, imageUrl: String, inStock: Bool, isIcon: Bool, isPinned: Bool ) {
        
        self.title = title
        self.designerName = designerName
        self.desginerSlug = designerSlug
        self.discount = discount
        self.freeShipping = freeShipping
        self.imageUrl = imageUrl
        self.inStock = inStock
        self.isIcon = isIcon
        self.onSale = onSale
        self.price = price
        self.salePrice = salePrice
        self.slug = slug
        self.isPinned = isPinned
        
    }
    
}
