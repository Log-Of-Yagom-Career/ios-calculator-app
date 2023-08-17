//
//  ExpressionParserTests.swift
//  ExpressionParserTests
//
//  Created by Baem on 2022/09/27.
//

import XCTest
@testable import Calculator

final class ExpressionParserTests: XCTestCase {
    var sut: ExpressionParser!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_parse실행시_정상적인값을_입력했을_때_입력개수와_result_값이_같은지() {
        // given
        let given1 = " 132.0 + 14.5 / 112.3 * 13.0 "
        let given2 = " 132.0 + 14.5 / 112.3 * 13.0"
        let given3 = "132.0 + 14.5 / 112.3 * 13.0"
        let expression2Result = (132.0+14.5)/112.3*13.0
        
        // when
        var result1 = try? ExpressionParser.parse(from: given1)
        var result2 = try? ExpressionParser.parse(from: given2)
        var result3 = try? ExpressionParser.parse(from: given3)
        
        // then
        XCTAssertEqual(try? result1?.result(), expression2Result)
        XCTAssertEqual(try? result2?.result(), expression2Result)
        XCTAssertEqual(try? result3?.result(), expression2Result)
    }
    
    func test_parse실행시_비정상적인값을_입력했을_때_올바른_오류를_던지는지() {
        // given
        let given1 = " agg + 14.5 / 112.3 * 13.0 "
        
        do {
        // when
           let _ = try ExpressionParser.parse(from: given1)
        } catch {
        // then
            XCTAssertEqual(ExpressionParserError.canNotChangeDouble, error as! ExpressionParserError)
        }
    }
    
    func test_parse실행시_맨_앞의_피연산자가_음수값을_가지게_되어도_올바르게_처리가_되는지() {
        // given
        let given1 = " -132.0 + 14.5 / 112.3 * 13.0"
        let given2 = "- 132.0 + 14.5 / 112.3 * 13.0 "
        let expression2Result = (-132.0+14.5)/112.3*13.0
        
        // when
        var result1 = try? ExpressionParser.parse(from: given1)
        var result2 = try? ExpressionParser.parse(from: given2)
        
        // then
        XCTAssertEqual(try? result1?.result(), expression2Result)
        XCTAssertEqual(try? result2?.result(), expression2Result)
    }
}
