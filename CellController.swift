//
//  CellController.swift
//  To do
//
//  Created by Rob Glazer on 7/9/19.
//  Copyright © 2019 Rob Glazer. All rights reserved.
//

import UIKit

protocol Modify{
    func modify(test:String, row: Int)
    func delete(row: Int)
    func add()
    
}

protocol Pressed{
    func pressed(row: Int)
}


class CellController: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descLabelOutlet.becomeFirstResponder()
        
        // Initialization code
        
        
    }
    
    
    var mod: Modify?
    var click: Pressed?
    var row: Int?
    var items: [Item]?
    
    
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    
    
    
    @IBOutlet weak var descLabelOutlet: UITextField!
    
    
    //Make it so when editing is finished, if item is not final item and is blank, delete it from items.
    
    @IBAction func checkButton(_ sender: UIButton) {
        //checkButton pressed
        click?.pressed(row: self.row!)
        if items![self.row!].checked{
            let pressedHighlight = UIColor.init(red: 0.97, green: 0.9, blue: 0.9, alpha: 0.91)
            self.backgroundColor=pressedHighlight
            descLabelOutlet.backgroundColor=pressedHighlight
        }
            
            
        else{
            self.backgroundColor=UIColor.white
            descLabelOutlet.backgroundColor=UIColor.white
        }
        
    }
    
    @IBAction func plusPressed(_ sender: UIButton) { //Not helping...
        mod?.modify(test: descLabelOutlet.text!, row: self.row!)
        if self.row != (items!.count-1) && descLabelOutlet.text == "" {
            mod?.delete(row: self.row!)
        }
    }
    
    
    @IBAction func descReturned(_ sender: Any) {
        //called when return is pressed
        
        //add an empty object to items, change text of item in items, and change text of text label
        mod?.modify(test: descLabelOutlet.text!, row: self.row!)
        
        //        if self.row != (items!.count-1) && descLabelOutlet.text == "" {
        //            mod?.delete(row: self.row!)
        //        }
        //        else if self.row == (items!.count-1) && descLabelOutlet.text != ""  {
        //            mod?.add()
        //        }
        
    }
    
    
    @IBAction func descDoneEditing(_ sender: Any) {
        //called when edit box exited
        //add an empty object to items, change text of item in items, and change text of text label
        mod?.modify(test: descLabelOutlet.text!, row: self.row!)
        if self.row != (items!.count-1) && descLabelOutlet.text == "" {
            mod?.delete(row: self.row!)
        }
        else if self.row == (items!.count-1) && descLabelOutlet.text != ""  {
            mod?.add()
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

