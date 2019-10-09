//
//  CategoryViewModel.swift
//  TodoeyRxSwiftAndMVVM
//
//  Created by Julio Collado on 10/7/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

class CategoryViewModel {
    
    let service = RealmMananger.shared
    var categoryList = RealmMananger.shared.get(objectsType: Category.self)
    
    func addCategory(categoryTitle: String) {
        do {
             let category = Category()
             category.title = categoryTitle
             try service.save(object: category)
        } catch {
            print("ERROR: \(error)")
        }
    }

}
