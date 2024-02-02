//
//  HomeViewController.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 24/01/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homePresenter: HomePresenterProtocol?
    var loadingView: UIActivityIndicatorView!
    
    let searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MELI") 
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Buscar"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    convenience init(presenter: HomePresenterProtocol) {
        self.init()
        self.homePresenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shop App"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        
        view.backgroundColor = .systemYellow
        
        loadingView = LoadingViewManager.configureLoadingView(in: view)
        view.addSubview(loadingView)
        
        configureSearchIconImageView()
        configureTextField()
        
        NSLayoutConstraint.activate([
                loadingView!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loadingView!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
            
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), 
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    func configureSearchIconImageView() {
        view.addSubview(searchIconImageView)
        
        NSLayoutConstraint.activate([
            searchIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchIconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            searchIconImageView.widthAnchor.constraint(equalToConstant: 120),
            searchIconImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func configureTextField() {
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: searchIconImageView.bottomAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
        ])
        
        textField.delegate = self
        textField.textAlignment = .left
        textField.returnKeyType = .search
    }
    
    @objc private func handleTap() {
        textField.resignFirstResponder()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        
    }
    
    func showLoadingView() {
        LoadingViewManager.showLoadingView(loadingView)
    }
    
    func hideLoadingView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
           LoadingViewManager.hideLoadingView(self.loadingView)
        }
    }
    
    func showGenericErrorAlert() {
        DispatchQueue.main.async {
            AlertManager.showAlert(type: .genericError, in: self)
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let searchText = textField.text, !searchText.isEmpty else {
            AlertManager.showAlert(type: .inputError, in: self)
            return false
        }
        
        textField.resignFirstResponder()
        homePresenter?.searchButtonTapped(with: textField.text ?? "")
        return true
    }
}
