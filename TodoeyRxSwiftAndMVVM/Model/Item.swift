//
//  Item.swift
//  TodoeyRxSwiftAndMVVM
//
//  Created by Julio Collado on 10/7/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var done: Bool = false
    let parentCategory = LinkingObjects<Category>(fromType: Category.self, property: "items")
}
