//
//  Product.swift
//  LystSneakers
//
//  Created by Jaz King on 09/08/2017.
//  Copyright © 2017 Jaz King. All rights reserved.
//

import Foundation
import Foundation
import UIKit

public class Product {
    
    public let title: String
    public let designerName: String
    public let desginerSlug: String
    public let discount: String
    public let price: String
    public let salePrice: String
    public let slug: String
    public let inStock: Bool
    public let isIcon: Bool
    public let onSale: Bool
    public let freeShipping: Bool
    public let isPinned: Bool
    public let imageUrl: String
    
    public init(title : String, designerName: String, designerSlug: String, price: String, onSale: Bool, salePrice: String, slug: String, discount: String, freeShipping: Bool, imageUrl: String, inStock: Bool, isIcon: Bool, isPinned: Bool ) {
        
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
