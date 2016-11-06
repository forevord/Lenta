//
//  News.swift
//  Lenta Ru
//
//  Created by Pavel Salkevich on 06.10.16.
//  Copyright © 2016 Pavel Salkevich. All rights reserved.
//

import Foundation

class News: NSObject {
    var title:String! = ""
    var id:String! = ""
    var rightcol:String! = ""
    var modifier:String! = ""
    
    init(title:String, id:String, rightcol:String) {
        self.title = title
        self.id = id
        self.rightcol = rightcol
        }
}
