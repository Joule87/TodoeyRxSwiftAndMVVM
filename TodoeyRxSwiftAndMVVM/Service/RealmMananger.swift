//
//  CoreDataManager.swift
//  Todoey
//
//  Created by Julio Collado on 9/10/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMananger {
    
    static let shared = RealmMananger()
    private var realm = try! Realm()
    
    private init() {
        print("Realm file path: \(String(describing: Realm.Configuration.defaultConfiguration.fileURL?.absoluteString))")
    }
    
    // MARK: - Realm Methods
    
    func get<T: Object>(objectsType: T.Type) -> Results<T> {
        let objects = realm.objects(objectsType)
        return objects
    }
 
    func save(object: Object) throws {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            throw RealmError.notSaved(error: error)
        }
    }
    
    func remove(_ object: Object, cascading: Bool) {
        do {
            try realm.write {
                realm.delete(object, cascading: cascading)
            }
        } catch {
            print("Error trying to delete Object: \(error)")
        }
    }
    
    func removeList<T:Object>(_ objects: List<T>) {
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            print("Error trying to delete Object: \(error)")
        }
    }
    
    func update(action: ()->()) {
        do {
            try realm.write {
                action()
            }
        } catch {
            print("Error trying to update data: \(error)")
        }
    }
    
    
}
