//
//  Products.swift
//  carepal@sgapp
//
//  Created by Goh Qi Xun on 2/2/21.
//

import Foundation

class Products
{
    var Price:Double = 0.0
    var Quantity:Int = 0
    
    init() {
        
    }
    
    init(price:Double, quantity:Int) {
        self.Price = price
        self.Quantity = quantity
    }
}
