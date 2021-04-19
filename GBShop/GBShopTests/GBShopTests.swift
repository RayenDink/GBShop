//
//  GBShopTests.swift
//  GBShopTests
//
//  Created by Rayen on 4/15/21.
//

import XCTest
@testable import GBShop

class AuthTests: XCTestCase {
    let requestFactory = RequestFactory()
    lazy var auth = requestFactory.makeAuthRequestFatory()
    lazy var errorParser = requestFactory.makeErrorParser()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testLogin() throws {
        let signedIn = expectation(description: "login")
        auth.login(userName: "Somebody", password: "mypassword", completionHandler: { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.user.id, 123)
                XCTAssertEqual(model.user.name, "John")
                signedIn.fulfill()
            case .failure(let error):
                let error = self.errorParser.parse(error)
                XCTFail(error.localizedDescription)
            }
        })
        self.waitForExpectations(timeout: 3)
    }

    func testLogout() throws {
        let logout = expectation(description: "logout")
        auth.logout(id: 123) { response in
            switch response.result {
            case .success(let responseModel):
                XCTAssertEqual(responseModel.result, 1)
                logout.fulfill()
            case .failure(let error):
                let error = self.errorParser.parse(error)
                XCTFail(error.localizedDescription)
            }
        }
        self.waitForExpectations(timeout: 3)
    }

    func testRegister() throws {
        let register = expectation(description: "register")
        auth.register(id: 123,
                      userName: "Somebody",
                      password: "mypassword",
                      email: "some@some.ru",
                      gender: "m",
                      creditCard: "9872389-2424-234224-234",
                      bio: "This is good! I think I will switch to another language",
                      completionHandler: { response in
            switch response.result {
            case .success(let responseModel):
                XCTAssertEqual(responseModel.result, 1)
                register.fulfill()
            case .failure(let error):
                let error = self.errorParser.parse(error)
                XCTFail(error.localizedDescription)
            }
        })
        self.waitForExpectations(timeout: 3)
    }

    func testEdit() throws {
        let edit = expectation(description: "edit")
        auth.changeUserData(id: 123,
                      userName: "Somebody",
                      password: "mypassword",
                      email: "some@some.ru",
                      gender: "m",
                      creditCard: "9872389-2424-234224-234",
                      bio: "This is good! I think I will switch to another language",
                      completionHandler: { response in
            switch response.result {
            case .success(let responseModel):
                XCTAssertEqual(responseModel.result, 1)
                edit.fulfill()
            case .failure(let error):
                let error = self.errorParser.parse(error)
                XCTFail(error.localizedDescription)
            }
        })
        self.waitForExpectations(timeout: 3)
    }
}
