//
//  ProductModel.swift
//  SearchProject
//
//  Created by Paolo Ramos Mendez on 5/19/17.
//  Copyright © 2017 mojix. All rights reserved.
//

import UIKit
import SwiftyJSON
//product.displayName
//sku.sale_Price
//sku.thumbnailImage
//sku location

class ProductModel: NSObject {
    
    private var _productName: String
    private var _price: String
    private var _urlImage: String
    private var _location: String
    
    var productName: String {
        get{ return _productName }
        set{ _productName = newValue }
    }
    
    var price: String {
        get{ return _price }
        set{ _price = newValue }
    }
    
    var urlImage: String {
        get{ return _urlImage }
        set{ _urlImage = newValue }
    }
    
    var location: String {
        get{ return _location }
        set{ _location = newValue }
    }
    
    override init() {
        _productName = String()
        _price = String()
        _urlImage = String()
        _location = String()
    }
    
    init(JSONData: JSON) {
        _productName = JSONData["product.displayName"].stringValue
        _price = JSONData["sku.sale_Price"].stringValue
        _urlImage = JSONData["sku.thumbnailImage"].stringValue
        _location = JSONData["sky.location"].stringValue
    }
}

