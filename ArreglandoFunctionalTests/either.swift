//
//  either.swift
//  ArreglandoFunctionalTests
//
//  Created by Antonio Muñoz on 5/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest
@testable import ArreglandoFunctional

class either: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let et = Either<String, Int>(left: "wwww2")
        
        
        let ord = isLeft(e: et)
        
        let ffpp = lefts(l: [et])
        
        
        let port = 900000000
        let gpo = 900000
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
