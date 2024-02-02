import XCTest
@testable import ShopApp

final class SearchResultPresenterTests: XCTestCase {

    var presenter: SearchResultPresenterProtocol!
    var mockView: MockSearchResultView!
    var mockInteractor: MockSearchResultInteractor!

    override func setUpWithError() throws {
        mockView = MockSearchResultView()
        mockInteractor = MockSearchResultInteractor()
        presenter = SearchResultPresenter(view: mockView, interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        presenter = nil
        mockView = nil
        mockInteractor = nil
    }

    func testSearchButtonTappedWithValidText() throws {
        let searchText = "Auto"
        mockInteractor.mockSearchResult = [ProductModel(id: "1", title: "auto", thumbnail: "", price: 1000)]
        mockInteractor.mockError = nil
        let expectation = XCTestExpectation(description: "Se espera que la búsqueda tenga éxito")
        
        presenter.searchButtonTapped(with: searchText)
        
        XCTAssertTrue(mockView.isLoadingViewShown, "La vista debería mostrar el loadingView")
        XCTAssertTrue(mockInteractor.isPerformSearchCalled, "La función performSearch del interactor debería ser llamada")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockView.isTableViewUpdated, "La tabla debería ser actualizada con los productos")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testSearchButtonTappedWithInvalidText() throws {
        // Arrange
        let searchText = "Prueba Fallida"
        mockInteractor.mockSearchResult = nil
        mockInteractor.mockError = NSError(domain: "MockError", code: 0, userInfo: nil)
        let expectation = XCTestExpectation(description: "Se espera que la búsqueda falle")
        
        // Act
        presenter.searchButtonTapped(with: searchText)
        
        XCTAssertTrue(mockInteractor.isPerformSearchCalled, "La función performSearch del interactor debería ser llamada")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockView.isGenericErrorAlertShown, "La alerta de error genérico debería mostrarse")
            XCTAssertFalse(self.mockView.isTableViewUpdated, "La tabla no debería ser actualizada con productos")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testDidSelectRowWithProduct() throws {
        let productID = "1"
        let indexPath = IndexPath(row: 0, section: 0)
        presenter = SearchResultPresenter(view: mockView, interactor: mockInteractor)
        
        presenter.didSelectRow(withProduct: productID, at: indexPath)
    }
}

class MockSearchResultView: SearchResultViewProtocol {
    var isLoadingViewShown = false
    var isGenericErrorAlertShown = false
    var isTableViewUpdated = false
    
    func showLoadingView() {
        isLoadingViewShown = true
    }
    
    func hideLoadingView() {
        isLoadingViewShown = false
    }
    
    func showGenericErrorAlert() {
        isGenericErrorAlertShown = true
    }
    
    func updateTableView(withData data: [ProductModel]) {
        isTableViewUpdated = true
    }
}

class MockSearchResultInteractor: SearchResultInteractorProtocol {
    var isPerformSearchCalled = false
    var mockSearchResult: [ProductModel]?
    var mockError: Error?
    
    func performSearch(with text: String, completion: @escaping ([ProductModel]?, Error?) -> Void) {
        isPerformSearchCalled = true
        
        // Simula la respuesta del interactor
        DispatchQueue.global().async {
            completion(self.mockSearchResult, self.mockError)
        }
    }
}

class MockSearchResultRouter: SearchResultRouterProtocol {
    var isNavigateToProductDetailCalled = false
    
    func navigateToProductDetail(from view: UIViewController, with productID: String) {
        isNavigateToProductDetailCalled = true
    }
}
