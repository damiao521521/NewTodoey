//
//  Data.swift
//  Todoey
//
//  Created by Jun Miao on 01/05/2018.
//  Copyright © 2018 Jun Miao. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
    
}
