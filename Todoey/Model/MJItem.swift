//
//  MJItem.swift
//  Todoey
//
//  Created by Jun Miao on 02/05/2018.
//  Copyright © 2018 Jun Miao. All rights reserved.
//

import Foundation
import RealmSwift

class MJItem: Object {
    @objc dynamic var toDoTitle : String = ""
    @objc dynamic var toDoCheck : Bool = false
    
    var parentCategory = LinkingObjects(fromType: MJCategory.self, property: "mjItems")
}



