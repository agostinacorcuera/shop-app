import XCTest
@testable import ShopApp

class HomePresenterTests: XCTestCase {

    func testSearchButtonTappedWithValidText() {
        let mockView = MockHomeViewController()
        let mockInteractor = MockHomeInteractor()
        let mockRouter = MockHomeRouter()
        let presenter = HomePresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
        let expectation = XCTestExpectation(description: "Se espera que la búsqueda tenga éxito")
        
        presenter.searchButtonTapped(with: "Moto")

        XCTAssertTrue(mockInteractor.isPerformSearchCalled, "La función performSearch del interactor debería ser llamada")
        
        mockInteractor.mockSearchResult = [ProductModel(id: "1", title: "iPhone", thumbnail: "", price: 1000)]
        mockInteractor.mockError = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(mockView.isLoadingViewShown, "El loadingView debería ocultarse después de la búsqueda")
            //XCTAssertTrue(mockRouter.isNavigateToSearchResultCalled, "La función navigateToSearchResult del router debería ser llamada")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSearchButtonTappedWithInvalidText() {
        let mockView = MockHomeViewController()
        let mockInteractor = MockHomeInteractor()
        let mockRouter = MockHomeRouter()
        let presenter = HomePresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
        let expectation = XCTestExpectation(description: "Se espera que la búsqueda falle")
        
        presenter.searchButtonTapped(with: "")
      
        XCTAssertTrue(mockInteractor.isPerformSearchCalled, "La función performSearch del interactor debería ser llamada")
        
        mockInteractor.mockSearchResult = nil
        mockInteractor.mockError = NSError(domain: "MockError", code: 0, userInfo: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(mockView.isLoadingViewShown, "El loadingView debería ocultarse después de la búsqueda")
            XCTAssertTrue(mockView.isGenericErrorAlertShown, "La alerta de error genérico debería mostrarse")
            XCTAssertFalse(mockRouter.isNavigateToSearchResultCalled, "La función navigateToSearchResult del router no debería ser llamada")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}

class MockHomeViewController: HomeViewController {
    var isLoadingViewShown = false
    var isGenericErrorAlertShown = false
    
    override func showLoadingView() {
        isLoadingViewShown = true
    }
    
    override func hideLoadingView() {
        isLoadingViewShown = false
    }
    
    override func showGenericErrorAlert() {
        isGenericErrorAlertShown = true
    }
}

class MockHomeInteractor: HomeInteractor {
    var isPerformSearchCalled = false
    var mockSearchResult: [ProductModel]?
    var mockError: Error?
    
    override func performSearch(with text: String, completion: @escaping ([ProductModel]?, Error?) -> Void) {
        isPerformSearchCalled = true
        completion(mockSearchResult, mockError)
    }
}

class MockHomeRouter: HomeRouter {
    var isNavigateToSearchResultCalled = false
    
    func navigateToSearchResult(from view: HomeViewController, with products: [ProductModel]) {
        isNavigateToSearchResultCalled = true
    }
}
