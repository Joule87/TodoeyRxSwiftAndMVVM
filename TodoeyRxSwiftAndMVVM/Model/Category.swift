//
//  Category.swift
//  TodoeyRxSwiftAndMVVM
//
//  Created by Julio Collado on 10/7/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var title: String?
    @objc dynamic var createdDate = Date()
    var items = List<Item>()
    
}
