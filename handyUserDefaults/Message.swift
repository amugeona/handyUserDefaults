//
//  Message.swift
//  handyUserDefaults
//
//  Created by KimYong Gyun on 12/2/17.
//  Copyright © 2017 haruair. All rights reserved.
//

import Foundation

class Message : NSObject {
    var text = ""
    var koala = "Koooo alaaaa"
    var age = 100
    let decimal: Int = 1
    
    init(text: String) {
        self.text = text
    }
    
    override init() {
    }
}
