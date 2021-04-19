//
//  ApiTest.swift
//  GBShop
//
//  Created by Rayen on 4/19/21.
//

import XCTest
@testable import GBShop

class ProductApiTests: XCTestCase {

    // Given
    let requestFactory = RequestFactory()
    lazy var productFactoy = requestFactory.makeProductRequestFactory()
    lazy var errorParser = requestFactory.makeErrorParser()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testGetProduct() throws {
        // When
        let signedIn = expectation(description: "getProduct")
        productFactoy.getProductById(id: 1) { response in
            // Then
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.description, "Мощный игровой ноутбук")
                signedIn.fulfill()
            case .failure(let error):
                let error = self.errorParser.parse(error)
                XCTFail(error.localizedDescription)
            }
        }
        self.waitForExpectations(timeout: 3)
    }

    func testGetProductList() throws {
        // When
        let signedIn = expectation(description: "getProductList")
        productFactoy.getProductList(page: 1, categotyId: 1) { response in
            // Then
            switch response.result {
            case .success(let products):
                signedIn.fulfill()
            case .failure(let error):
                let error = self.errorParser.parse(error)
                XCTFail(error.localizedDescription)
            }
        }
        self.waitForExpectations(timeout: 3)
    }

}
