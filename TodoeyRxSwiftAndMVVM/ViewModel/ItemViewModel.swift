//
//  ItemViewModel.swift
//  TodoeyRxSwiftAndMVVM
//
//  Created by Julio Collado on 10/7/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

class ItemViewModel {
    var service = RealmMananger.shared
    var selecteCategory: Category?
    
    func addItem(itemName: String) {
        service.update {
            let item = Item()
            item.name = itemName
            selecteCategory?.items.append(item)
        }
    }
    
    func updateItem(_ action: () -> ()){
        service.update(action: action)
    }

}
