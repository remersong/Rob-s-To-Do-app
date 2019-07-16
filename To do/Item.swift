//
//  Item.swift
//  To do
//
//  Created by Rob Glazer on 7/16/19.
//  Copyright © 2019 Rob Glazer. All rights reserved.
//

import Foundation
import UIKit

class Item: NSObject, NSCoding{
    
    //Item: An object containing a task description and boolean that states whether the task has been completed or not
    
    var desc = ""
    var checked = false
    
    init(desc: String, checked: Bool){
        self.desc = desc
        self.checked = checked
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let desc = aDecoder.decodeObject(forKey: "desc") as! String
        let checked = aDecoder.decodeBool(forKey: "checked")
        
        self.init(desc: desc, checked: checked)
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(desc, forKey: "desc")
        aCoder.encode(checked, forKey: "checked")
        
    }
    
    
    
    
    
}
