//
//  RealmError.swift
//  TodoeyRealmAndVIPER
//
//  Created by Julio Collado on 9/20/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

enum RealmError: Error {
    case notSaved(error: Error)
}
