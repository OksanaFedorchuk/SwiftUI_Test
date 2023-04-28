//
//  VendorsListVMTests.swift
//  VendorsListVMTests
//
//  Created by Oksana Fedorchuk on 24.04.2023.
//

import XCTest
@testable import SwiftUI_Test

final class VendorsListVMTests: XCTestCase {
    var sutVendorsListVM: VendorsListVM!
    
    override func setUpWithError() throws {
        sutVendorsListVM = VendorsListVM()
    }
    
    override func tearDownWithError() throws {
        sutVendorsListVM = nil
    }
    
    func testListIsLoaded() throws {
        let expectation = XCTestExpectation(description: "fetches data and updates properties on init")
        
        let delay = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            expectation.fulfill()
            
            XCTAssertFalse(self.sutVendorsListVM.vendors.isEmpty)
        }
        
        wait(for: [expectation], timeout: delay)
    }
    
    func testSearchDoesntStartUnderTwoCharacters() throws {
        let expectation = XCTestExpectation(description: "doesn't start search with under 3 characters input")
        var initialCount = 0
        sutVendorsListVM.searchText = "Fl"
        
        let delay = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            initialCount = self.sutVendorsListVM.vendors.count
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay * 2) {
            expectation.fulfill()
            
            XCTAssertEqual(self.sutVendorsListVM.vendors.count, initialCount)
        }
        
        wait(for: [expectation], timeout: delay * 2)
    }
    
    func testSearchStartsWithThreePlus() throws {
        let expectation = XCTestExpectation(description: "search starts with 3+ characters input")
        sutVendorsListVM.searchText = "Flo"
        
        let delay = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            expectation.fulfill()
            
            XCTAssertEqual(self.sutVendorsListVM.vendors.count, 1)
        }
        
        wait(for: [expectation], timeout: delay)
    }
    
    func testEmptyListEror() throws {
        let expectation = XCTestExpectation(description: "view mopdel should provide error for empty collection")
        sutVendorsListVM.searchText = "Floq3g"
        
        let delay = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            expectation.fulfill()
            
            XCTAssertEqual(self.sutVendorsListVM.vendors.count, 0)
            XCTAssertNotNil(self.sutVendorsListVM.errorWrapper)
        }
        
        wait(for: [expectation], timeout: delay)
    }
}
