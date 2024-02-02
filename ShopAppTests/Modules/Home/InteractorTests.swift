import XCTest
@testable import ShopApp

final class HomeInteractorTests: XCTestCase {

    var sut: HomeInteractor!

    override func setUpWithError() throws {
        sut = HomeInteractor()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testPerformSearchSuccess() throws {
        let searchText = "Auto"
        let expectation = XCTestExpectation(description: "Se espera que la búsqueda tenga éxito")

        sut.performSearch(with: "Motos") { (products, error) in
            XCTAssertNil(error, "No se espera un error")
            XCTAssertNotNil(products, "Se espera que los productos no sean nulos")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testPerformSearchFailure() throws {
        let expectation = XCTestExpectation(description: "Se espera que la búsqueda tenga éxito")
        let invalidURL = "https://example.invalidurl"

        sut.performSearch(with: invalidURL) { (products, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(products)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

}
