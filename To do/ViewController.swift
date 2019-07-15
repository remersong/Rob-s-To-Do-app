//
//  ViewController.swift
//  To do
//
//  Created by Rob Glazer on 7/4/19.
//  Copyright © 2019 Rob Glazer. All rights reserved.
//

//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Modify, Pressed{
    
    
    //TODO: [Adjust table view to move for keyboard]
    //TODO: [Make it so a text box can become first responder multiple times]
    //TODO: [Allow textview to store multiple lines]
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var items: [Item] = [ ] //List of items
    
    override func viewDidLoad() {
        let firstItem = Item(desc:"", checked: false)
        self.tableView.isEditing = true
        let itemstemp = UserDefaults.standard.data(forKey: "Items")
        do {
            let unarchiveitems = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(itemstemp ?? NSKeyedArchiver.archivedData(withRootObject: [Item(desc: "", checked: false)], requiringSecureCoding: true)) as? [Item]
            items = unarchiveitems!
        }
        catch{
            print("Error retrieving data")
        }
        
        
        //      immediately start blank list with empty item
        if (items.count<1){
            items.append(firstItem)
        }
        tableView.reloadData()
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false //prevents row from being highlighted by user
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count //Ensures that rows in table equal number of objects in items - Each cell will be solely based off of the properties in items
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //allows slide to delete for list
        if items.count>1{ //will only work if there are multiple objects in items
            if editingStyle == .delete{
                items.remove(at: indexPath.row)
                store()
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //moves items around
        
        if items[sourceIndexPath.row].desc != "" && items[destinationIndexPath.row].desc != ""
            //ensures blank item is not moved
        {
            let temp = items[sourceIndexPath.row]
            items.remove(at: sourceIndexPath.row)
            items.insert(temp, at: destinationIndexPath.row)
            store()
            
        }
        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellController  //Gives me access to cells
        
        
        
        cell.descLabelOutlet.text = items[indexPath.row].desc
        //Ensures that text matches Item desc
        
        if items[indexPath.row].checked{
            cell.checkButtonOutlet.setTitle("X", for: UIControl.State.normal)
        }
        else{
            cell.checkButtonOutlet.setTitle("O", for: UIControl.State.normal)
        }
        
        if items[indexPath.row].checked{
            cell.backgroundColor=UIColor.init(red: 0.97, green: 0.9, blue: 0.9, alpha: 0.91)
            cell.descLabelOutlet.backgroundColor=UIColor.init(red: 0.97, green: 0.9, blue: 0.9, alpha: 0.91)
        }
            
            
        else{
            cell.backgroundColor=UIColor.white
            cell.descLabelOutlet.backgroundColor=UIColor.white
        }
        //Changes button text between X and O, X=completed, O=incomplete - Will try to change to images when I work on UI.
        cell.mod = self
        cell.click = self
        cell.row = indexPath.row
        cell.items = items
        
        return cell
    }
    
    @IBAction func plusPressed(_ sender: UIButton) { //Adds item if plus key pressed
        if items[items.count-1].desc != ""
            //will not add if last item in list is blank
        {
            items.append(Item(desc:"", checked: false))
            store()
            tableView.reloadData()
        }
    }
    
    
    
    func modify(test: String, row: Int) { //takes in string from cell controller and changes the list
        items[row].desc=test
        store()
        
        tableView.reloadData()
    }
    func delete(row: Int) { //deletes cell at given row
        items.remove(at: row)
        store()
        
        tableView.reloadData()
    }
    
    
    func pressed(row: Int){ //changes state of button when cell is pressed by changing boolean in items
        if items[row].checked{
            items[row].checked=false
        }
        else{
            items[row].checked=true
        }
        //        store()
        tableView.reloadData()
        
    }
    func add(){
        items.append(Item(desc:"", checked: false))
        store()
        tableView.reloadData()
        
    }
    
    func store(){
        let userDefaults = UserDefaults.standard
        do {
            
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: self.items, requiringSecureCoding: false)
            userDefaults.set(encodedData, forKey: "Items")
        }
            
        catch{
            print("Error storing data")
        }
        
    }
    
    
}
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


