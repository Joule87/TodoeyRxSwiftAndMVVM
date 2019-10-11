//
//  ItemViewModel.swift
//  TodoeyRxSwiftAndMVVM
//
//  Created by Julio Collado on 10/7/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class ItemViewModel {
    var service = RealmMananger.shared
    var selecteCategory: Category? {
        didSet {
            getItemsFilter()
        }
    }
    
    let items = BehaviorSubject<[Item]>(value: [])
    
    func addItem(itemName: String) {
        service.update {
            let item = Item()
            item.name = itemName
            selecteCategory?.items.append(item)
        }
        getItemsFilter()
    }
    
    func updateItem(_ action: () -> ()){
        service.update(action: action)
    }
    
    func getItemsFilter(by text: String? = nil) {
        let itemList: [Item] = filterItemList(for: text)?.map{$0} ?? []
        items.onNext(itemList)
    }
    
    func filterItemList(for text: String?) -> List<Item>? {
        guard let textValue = text, !textValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return selecteCategory?.items
        }
        
        guard let itemsResult = selecteCategory?.items.filter("name CONTAINS[cd] %@", textValue) else {
            return nil
        }
        
        let convertedList = itemsResult.reduce(List<Item>()) { (list, element) -> List<Item> in
            list.append(element)
            return list
        }
         
        return convertedList
    }

}
