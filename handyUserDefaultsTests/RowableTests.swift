//
//  RowableTests.swift
//  handyUserDefaults
//
//  Created by KimYong Gyun on 12/2/17.
//  Copyright © 2017 haruair. All rights reserved.
//

import XCTest
@testable import handyUserDefaults

class RowableTests: XCTestCase {
    func testIsSerialisable () {
        let msg = Message(text: "Hello World")
        let message = Rowable(from: msg)
        let props = message.properties()
        
        XCTAssertEqual(props.first?.label, "text")
        let data = NSKeyedArchiver.archivedData(withRootObject: message)
        let result = NSKeyedUnarchiver.unarchiveObject(with: data) as! Rowable<Message>
        
        XCTAssertEqual(result.item.text, "Hello World")
        XCTAssertEqual(result.item.koala, "Koooo alaaaa")
        XCTAssertEqual(result.item.age, 100)
    }
}
