import XCTest
@testable import ShopApp

final class SearchResultInteractorTests: XCTestCase {

    var sut: SearchResultInteractorProtocol!

    override func setUpWithError() throws {
        sut = SearchResultInteractor()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testPerformSearchWithValidText() throws {
        let searchText = "Auto"
        let expectation = XCTestExpectation(description: "Se espera que la búsqueda tenga éxito")
        
    
        sut.performSearch(with: searchText) { (products, error) in
            XCTAssertNil(error, "No se espera un error")
            XCTAssertNotNil(products, "Se espera que los productos no sean nulos")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testPerformSearchWithInvalidText() throws {
        let searchText = "Busqueda fallida"
        let expectation = XCTestExpectation(description: "Se espera que la búsqueda falle")
        
        sut.performSearch(with: searchText) { (products, error) in
            XCTAssertNotNil(error, "Se espera un error")
            XCTAssertNil(products, "No se espera que los productos sean nulos")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
