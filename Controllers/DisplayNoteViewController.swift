//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//
import RealmSwift
import UIKit

class DisplayNoteViewController: UIViewController {

    var note: Note?
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteContentTextView: UITextView!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = note {
            // if stuff already exists in note
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        } else {
            // if note is nil
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
  }

    //prevcode
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let identifier = segue.identifier {
//            if identifier == "Cancel" {
//                print("Cancel button tapped")
//            } else if identifier == "Save" {
//                print("Save button tapped")
//            }
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
        if segue.identifier == "Save" {
            if let note = note {
                let newNote = Note()
                // if existing note, just update
                newNote.title = noteTitleTextField.text ?? ""
                newNote.content = noteContentTextView.text ?? ""
                Realmhelper.updateNote(note, newNote: newNote)
                //reload data so edits are reflected
//                listNotesTableViewController.tableView.reloadData()
            } else {
                // if new note, create new note and add to notes array
                // dont have to refresh because didSet property observer does it
                let note = Note()
                note.title = noteTitleTextField.text ?? ""
                note.content = noteContentTextView.text ?? ""
                note.modificationTime = NSDate()
                Realmhelper.addNote(note)
            }
            listNotesTableViewController.notes = Realmhelper.retrieveNotes()
        }
    }
//prev code
//        if let identifier = segue.identifier {
//            if identifier == "Cancel" {
//                print("Cancel button tapped")
//            } else if identifier == "Save" {
//                print("Save button tapped")
//                
//                // 1
//                let note = Note()
//                // 2
//                note.title = noteTitleTextField.text ?? ""
//                note.content = noteContentTextView.text
//                // 3
//                note.modificationTime = NSDate()
//                
//                
//                
//                // ADDING NEW NOTES TO NOTES ARRAY
//                // 1
//                let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
//                // 2
//                listNotesTableViewController.notes.append(note)
//            }
//        }
//    }

}
