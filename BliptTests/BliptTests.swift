//
//  BliptTests.swift
//  BliptTests
//
//  Created by Travis Baksh on 4/17/23.
//

import XCTest
@testable import Blipt

final class BliptTests: XCTestCase {
  
  //
  //  func removeLeftmostInteger(from x: Double) -> Double {
  //      let integerPart = Int(x)
  //      let fractionalPart = x - Double(integerPart)
  //      let decimalFraction = Decimal(fractionalPart)
  //      let factor = pow(10, decimalFraction.scale)
  //      let result = Double(truncating: (decimalFraction * Decimal(factor)).rounded()) / factor
  //      return result
  //  }
  //
  //
  //
  //  func testRemoveLeftmostInteger() {
  //    XCTAssertEqual(removeLeftmostInteger(from: 1.0), 0.0)
  //    XCTAssertEqual(removeLeftmostInteger(from: 1234.56), 234.56)
  //    XCTAssertEqual(removeLeftmostInteger(from: 12.4), 2.4)
  //    XCTAssertEqual(removeLeftmostInteger(from: 2.2), 0.2)
  //    XCTAssertEqual(removeLeftmostInteger(from: 0.05), 0.0)
  //    XCTAssertEqual(removeLeftmostInteger(from: 89.59), 0.59)
  //  }
  //
  //}
  //
  //struct Price: Codable {
  //  var amount: Double
  //}
  //extension Price: CustomStringConvertible {
  //  var description: String {
  //    let formatter = NumberFormatter()
  //    formatter.numberStyle = .currency
  //    formatter.maximumFractionDigits = 2
  //
  //    let number = NSNumber(value: amount)
  //    return formatter.string(from: number)!
  //  }
  //}
}
