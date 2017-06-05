//
//  CarteTests.swift
//  Carte
//
//  Created by Suyeol Jeon on 05/06/2017.
//

import XCTest
@testable import Carte

final class CarteTests: XCTestCase {
  override func setUp() {
    super.setUp()
    Carte.infoDictionary = nil
  }

  override func tearDown() {
    Carte.infoDictionary = nil
    super.tearDown()
  }

  // MARK: items(from:)

  func testItemsFromInfo_nilInfo() {
    let items = Carte.items(from: nil)
    XCTAssertNil(items)
  }

  func testItemsFromInfo_emptyInfo() {
    let items = Carte.items(from: [:])
    XCTAssertNil(items)
  }

  func testItemsFromInfo_emptyCarteDict() {
    let items = Carte.items(from: ["Carte": []])
    XCTAssertNotNil(items)
    XCTAssertTrue(items!.isEmpty)
  }

  func testItemsFromInfo_singleItem() {
    let items = Carte.items(from: ["Carte": [
      [
        "name": "Then",
        "text": "VGhpcyBpcyBNSVQgbGljZW5zZQ==",
      ],
    ]])
    XCTAssertEqual(items!.count, 1)
    XCTAssertEqual(items!.first!.name, "Then")
    XCTAssertEqual(items!.first!.licenseText, "This is MIT license")
  }

  func testItemsFromInfo_includeInvalidData() {
    let items = Carte.items(from: ["Carte": [
      [
        "name": "Then",
      ],
      [
        "_name": "URLNavigator",
        "text": "QlNE",
      ],
    ]])
    XCTAssertEqual(items!.count, 1)
    XCTAssertNil(items!.first!.licenseText)
  }

  func testItemsFromInfo_sort() {
    let items = Carte.items(from: ["Carte": [
      ["name": "C"],
      ["name": "A"],
      ["name": "B"],
    ]])
    XCTAssertEqual(items!.count, 3)
    XCTAssertEqual(items!.map { $0.name }, ["A", "B", "C"])
  }


  // MARK: items(from:)

  func testItems_nilInfo() {
    Carte.infoDictionary = nil
    XCTAssertEqual(Carte.items.count, 1)
    XCTAssertEqual(Carte.items.first?.name, "Carte")
  }

  func testItems() {
    Carte.infoDictionary = [
      "Carte": [
        ["name": "C"],
        ["name": "A"],
        ["name": "B"],
      ]
    ]
    XCTAssertEqual(Carte.items.count, 4)
    XCTAssertEqual(Carte.items.map { $0.name }, ["A", "B", "C", "Carte"])
  }
}
