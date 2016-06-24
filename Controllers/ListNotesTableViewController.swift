//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import RealmSwift
import UIKit

class ListNotesTableViewController: UITableViewController {

    
    var notes: Results<Note>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // store identifier of the seague that was triggered into identifier(a local variable)
        if let identifier = segue.identifier {
            // checks to see if the "displayNote" segue was triggered
            if identifier == "displayNote" {
                // prints message to the console
                print("Table view cell tapped")
                
                
                // indexPathForSelectedRow -> accesses a particular cell's index path which has section and row properties
                // <- forcefully unrwrapping so have to make sure not nil
                let indexPath = tableView.indexPathForSelectedRow!
                // retrieve note from notes array
                let note = notes[indexPath.row]
                // getting access to Display Note View Controller, downcasting
                let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
                // set not property
                displayNoteViewController.note = note
                
                
                
            } else if identifier == "addNote" {
                print("+ button tapped")
            }
        }
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    notes = Realmhelper.retrieveNotes()
  }
    
    // how many cells should it display? Usually set dynamically but hardcoded for now
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    // what cell should be displayed in a particular row of the table
    // created UITableViewCell, updating it, returning it to table view
    // index path -> section and row in the table the cell constructed belongs to
    // default - 1 section
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        //  as! Lis... is a downcast. Tells compiler that we expect dequeue.. to return a more specific type of UITableViewCell. Downcast works b/c ListNotesTableViewCell is a subclass of UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath) as! ListNotesTableViewCell
        
        // indexPath is passed into cellForRowAtIndexPath <- how the table view tells us what row it wants a cell for
        // access the row property of index path to figure out which row
        let row = indexPath.row
        
        // use the row to index notes array to get the right note obj
        let note = notes[row]
        
        // set the text to the title of the note
        cell.noteTitleLabel.text = note.title
        
        //coverting time of note to string
        // set text property to be the modified time
        cell.noteModificationTimeLabel.text = note.modificationTime.convertToString()
        
        //prev code
        // since cell now has type ListNOtesTableViewCell, can now access noteTitle and noteMod..Time properties
//        cell.noteTitleLabel.text = "note's title"
//        cell.noteModificationTimeLabel.text = "note's modification time"
        
        return cell
        
//prev code
//        // fetches actual cell that will be displayed in table
//        // gets reusable cell
//        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath)
//        
//        // set text property
//        cell.textLabel?.text = "Yay - it's working!"
//        
//        // return updated cell to be used within the table view
//        return cell
    }
    
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }
    
    
    // allow table view to have additional editing modes, like DELETE
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // delete note from Realm using
            Realmhelper.deleteNote(notes[indexPath.row])
            notes = Realmhelper.retrieveNotes()
//            notes.removeAtIndex(indexPath.row)
//            // updated so need to update itself
//            tableView.reloadData()
        }
    }
  
}