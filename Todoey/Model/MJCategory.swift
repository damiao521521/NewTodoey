//
//  MJCategory.swift
//  Todoey
//
//  Created by Jun Miao on 02/05/2018.
//  Copyright © 2018 Jun Miao. All rights reserved.
//

import Foundation
import RealmSwift

class MJCategory: Object {
    @objc dynamic  var name : String = ""
    
    let mjItems = List<MJItem>()
    
}
