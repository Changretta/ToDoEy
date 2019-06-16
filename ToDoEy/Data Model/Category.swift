//
//  Category.swift
//  ToDoEy
//
//  Created by JuanSpada on 14/06/2019.
//  Copyright © 2019 Juan-Spada. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
