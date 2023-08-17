//
//  CalculatorItemQueueTests.swift
//  CalculatorTests
//
//  Created by Baem on 2022/09/20.
//

import XCTest
@testable import Calculator

final class CalculatorItemQueueTests: XCTestCase {
    var sut: CalculatorItemQueue?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CalculatorItemQueue()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_CalculatorItemQueue의_enqueue실행시_queue_에_추가가되는지() {
        // given
        let number: CalculatorItem = "50"
        
        // when
        sut?.enqueue(number)
        
        // then
        XCTAssertTrue(sut?.isEmpty != nil)
    }
    
    func test_dequeue실행시_queue가_비어있을_때_nil을_리턴하는지() {
        // given
        
        // when
        let result = sut?.dequeue()
        
        // then
        XCTAssertNil(result)
    }
    
    func test_dequeue실행시_queue가_값을_가질때_dequeue의_값이_반환되고_삭제되는지() {
        // given
        let queue1: Int = 10
        
        // when
        sut?.enqueue(queue1)
        let result = sut?.dequeue()

        // then
        XCTAssertEqual(sut?.count, 0)
        XCTAssertEqual(result as! Int, queue1)
    }
    
    func test_peek실행시_큐의_첫_번째_요소를_반환하는지() {
        // given
        let queue1: Int = 1
        
        // when
        sut?.enqueue(queue1)
        let result = sut?.peek()
        
        // then
        XCTAssertEqual(result as! Int, 1)
    }
    
    func test_clear실행시_queue의_모든_요소들이_삭제되는지() {
        // given
        let queue1: Int = 2
        
        // when
        sut?.enqueue(queue1)
        sut?.clear()
        
        // then
        XCTAssertTrue(sut!.isEmpty)
    }
}
