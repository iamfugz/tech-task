//
//  TechTaskTests.swift
//  TechTaskTests
//
//  Created by kevin.fugaban on 8/26/22.
//

import XCTest
import Combine
@testable import TechTask

class TechTaskTests: XCTestCase {
    
    var airportViewModel: AirportViewModel!
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        airportViewModel = AirportViewModel(apiRequest: MockApiRequest())
        cancellables = []
    }
    
    override func tearDown() {
        super.tearDown()
        airportViewModel = nil
        cancellables = []
    }
    
    func test_getAirport() async{
        
        let expectation = XCTestExpectation(description: "Fetched airports")
        
        await airportViewModel.getAirports(isNetworkConnected: true)
        
        airportViewModel
            .$airports
            .dropFirst()
            .sink { value in
                XCTAssertTrue(!value.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 30)
        
        XCTAssertFalse(self.airportViewModel.isLoading)
        XCTAssertFalse(self.airportViewModel.hasError)
        XCTAssertEqual(self.airportViewModel.errorMessage, "")
    }
    
    func test_getCurrencyCode(){
        
        let actual = airportViewModel.getCurrencyCode(countryCode: "DE")
        let expected = "EUR"
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_getTimezone(){
        
        let actual = airportViewModel.getTimeZone(timeZoneName: "Pacific/Auckland")
        let expected = "GMT+12"
        
        XCTAssertEqual(actual, expected)
    }

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
