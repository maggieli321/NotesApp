//
//  Note.swift
//  MakeSchoolNotes
//
//  Created by Maggie Li on 6/23/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

// prev
//import Foundation
//
//class Note {
//    var title = ""
//    var content = ""
//    var modificationTime = NSDate()
//}

import Foundation
import RealmSwift

class Note: Object {
    dynamic var title = ""
    dynamic var content = ""
    dynamic var modificationTime = NSDate()
}