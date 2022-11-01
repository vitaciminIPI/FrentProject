//
//  Test_RegisterModel.swift
//  FrentMCTests
//
//  Created by daniel stefanus christiawan on 27/10/22.
//

import XCTest
@testable import FrentMC

final class Test_UserModel: XCTestCase {
    var model: UserModels!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        model = UserModels(name: "John Does123", phone_number: nil, email: "asdfsadf", password: "asawau", confirmPassword: "asawau", nim: nil, university: nil, location: nil, student_card: nil)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        model = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
//    func testIsValidName() {
//        model.name = "keanu reeves"
//
//        let isValidName = model.validateName()
//
//        XCTAssertTrue(isValidName)
//    }
//
//    func testIsIdentic() {
//        model.password = "adfasf"
//        model.confirmPassword = "adfasf"
//
//        let isIdentic = model.isIdenticalPassword()
//
//        XCTAssertTrue(isIdentic)
//    }
//
//    func testIsValidPassword() {
//        model.password = "asdfaA@7"
//        model.confirmPassword = "asdfaA@7"
//
//        let validatePass = model.validatePassword()
//
//        XCTAssertTrue(validatePass)
//    }
    
}
