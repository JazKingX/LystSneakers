//
//  DataMananger.swift
//  LystSneakers
//
//  Created by Jaz King on 24/07/2017.
//  Copyright © 2017 Jaz King. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    //Preferences for user
    enum Gender {
        case male
        case female
        case none
    }
    
    //Filter properties
    public var gender: Gender = .none
    public var category: String? = nil
    
    
    // public var url: String = "https://api.lyst.com/rest_api/components/feeds/?pre_product_type=Shoes"
    
    // Set URL
    func getUrl(_ gender: Gender, category: String?) -> String {
        
        var url: String = "https://api.lyst.com/rest_api/components/feeds/?pre_product_type=Shoes"
        
        switch gender {
        case .male:
            url.append("&pre_gender=M")
        case .female:
            url.append("&pre_gender=F")
        case .none:
            url = "https://api.lyst.com/rest_api/components/feeds/?pre_product_type=Shoes"
        }
        
        if gender != .none && category != nil {
            url.append("&pre_category=\(category!)")
        }
        
        return url
    }
    
    // Request data from URL
    func requestData(_ stringUrl: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        print("Request Data")
        
        Alamofire.request(stringUrl, method: .get).validate().responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                print("responce success")
                success(json)
                
            case .failure(let error):
                print("Failed to get responce \(error)")
                
            } //End of switch statement
            
        } //End of alamofire request
        
    }  //End of request function
    
    
    //Get objects from JSON data
    func getObjects(completionHandler : @escaping ([Product]) -> (),_ urlString:String) {
        
        DispatchQueue.main.async {
            
            var products = [Product]()
            
            self.requestData(urlString, success: {
                (JSONResponse) -> Void in
                
                let json = JSONResponse
                
                // Filter through products in json responce
                for product in json["products"] {
                    
                    //Create properties using product data from JSON responce
                    
                    let name = product.1["designer_name"].string
                    let title = product.1["title"].string
                    let designerSlug = product.1["designer_slug"].string
                    let price = product.1["price"].string
                    let salePrice = product.1["sale_price"].string
                    let slug = product.1["slug"].string
                    let discount = product.1["discount"].string
                    let freeShipping = product.1["free_shipping"].bool
                    let inStock = product.1["in_stock"].bool
                    let isIcon = product.1["is_icon"].bool
                    let onSale = product.1["on_sale"].bool
                    let isPinned = product.1["is_pinned"].bool
                    let image = product.1["image"].string
                    
                    // Create product instance and add to products array
                    
                    products.append(Product(title: title!, designerName: name!, designerSlug: designerSlug!, price: price!, onSale: onSale!, salePrice: salePrice!, slug: slug!, discount: discount!, freeShipping: freeShipping!, imageUrl: image!, inStock: inStock!, isIcon: isIcon!, isPinned: isPinned!))
                    
                }
                
                //Handle completion and return array
                completionHandler(products)
                //print("This is the products array count \(products.count)")
                
            }) {
                (error) -> Void in
                print(error)
            }
        }
    }
    
    //Get categories from URL
    func getCategories(completionHandler : @escaping ([String]) -> (),_ urlString:String) {
        
        //Dispatch using main thread for performance
        DispatchQueue.main.async {
            
            var categories:[String] = []
            
            self.requestData(urlString, success: {
                (JSONResponse) -> Void in
                
                let json = JSONResponse
                
                // Filter through products in json responce
                for product in json["filters"] {
                    let category = product.1["value"].string
                    categories.append(category!)
                }
                
                //Handle completion and return array
                completionHandler(categories)
                //print("This is the categories array count \(categories.count)")
                
            }) {
                (error) -> Void in
                print(error)
            }
        }
    }
    
}
