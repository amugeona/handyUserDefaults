//
//  Row.swift
//  handyUserDefaults
//
//  Created by KimYong Gyun on 12/2/17.
//  Copyright © 2017 haruair. All rights reserved.
//

import Foundation

class Row<T> {
    var type = T.self
    var item : T
    
    init(_ item: T) {
        self.item = item
    }
    
}
