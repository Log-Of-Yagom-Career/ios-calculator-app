//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Baem on 2022/09/20.
//

import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {
    var sut: CalculatorItemQueue?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CalculatorItemQueue()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_CalculatorItemQueue의_addQueue실행시_queue_에_추가가되는지() {
        // given
        let number: String = "50"
        
        // when
        sut?.addQueue(number)
        
        // then
        XCTAssertEqual(sut?.queue, ["50"])
    }
    
    func test_subtractQueue실행시_queue가_비어있을_때_nil을_리턴하는지() {
        // when
        let result = sut?.subtractQueue()
        
        // then
        XCTAssertNil(result)
    }
    
    func test_subtractQueue실행시_queue가_값을_가질때_그_다음값을_반환하는지() {
        // given
        sut?.queue = ["14512","abcd"]
        
        // when
        let _ = sut?.subtractQueue()
        
        // then
        XCTAssertEqual(sut?.queue.first, "abcd")
    }
    
    func test_subtractQueue실행시_queue가_제거_되었을때_0인덱스가_제거되는지() {
        // given
        sut?.queue = ["14512","abcd", "C"]
        
        // when
        let _ = sut?.subtractQueue()
        
        // then
        XCTAssertEqual(sut?.queue, ["abcd", "C"])
    }
}
