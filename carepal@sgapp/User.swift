//
//  User.swift
//  carepal@sgapp
//
//  Created by Goh Qi Xun on 26/1/21.
//

import Foundation

class User {
    var fName:String = ""
    var lName:String = ""
    var contact:String = ""
    var points:Int = 0
    
    init() {
        
    }
    
    init(first:String, last:String, no:String, points:Int) {
        self.fName = first
        self.lName = last
        self.contact = no
        self.points = points
    }
}
