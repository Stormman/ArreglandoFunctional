//
//  Boxtest.swift
//  ArreglandoFunctionalTests
//
//  Created by Antonio Muñoz on 5/11/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import XCTest
@testable import ArreglandoFunctional

class Boxtest: XCTestCase {
    
   
    func testExample() {
        
        let fr = Box(90)
        
        let prep = Box({(st : Int ) -> Int in st * 67       })
        
        let ot = prep.unBox()
        
        
        
        
        
        let okkk = 90000
        
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
