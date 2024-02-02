//
//  SearchResultViewController.swift
//  ShopApp
//
//  Created by Agostina Corcuera Di Salvo on 26/01/2024.
//

import Foundation
import UIKit

protocol SearchResultViewProtocol: AnyObject {
    func updateTableView(withData data: [ProductModel])
    func showLoadingView()
    func hideLoadingView()
    func showGenericErrorAlert()
}

class SearchResultViewController: UIViewController, SearchResultViewProtocol {

    var presenter: SearchResultPresenter?
    var loadingView: UIActivityIndicatorView?
    private var products: [ProductModel] = []
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Buscar"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Búsqueda"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
    
        view.backgroundColor = .systemYellow
        
        loadingView = LoadingViewManager.configureLoadingView(in: view)
        
        
        configureTextField()
        configureScrollView()
        configureTableView()
        
        tableView.reloadData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Configuration
    
    private func configureTextField() {
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
        
        
        textField.delegate = self
        textField.textAlignment = .left
        textField.returnKeyType = .search
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
    }
    
    private func configureTableView() {
        scrollView.addSubview(tableView)
        
        tableView.dataSource = self 
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        tableView.backgroundColor = .white
        tableView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func updateTableView(withData data: [ProductModel]) {
        products = data
        tableView.reloadData()
    }
    
    @objc private func handleTap() {
        textField.resignFirstResponder()
    }
    
    func showLoadingView() {
        LoadingViewManager.showLoadingView(loadingView!)
    }
    
    func hideLoadingView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
           LoadingViewManager.hideLoadingView(self.loadingView!)
        }
    }
    
    func showGenericErrorAlert() {
        DispatchQueue.main.async {
            AlertManager.showAlert(type: .genericError, in: self)
        }
    }
}

extension SearchResultViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let searchText = textField.text, !searchText.isEmpty else {
            AlertManager.showAlert(type: .inputError, in: self)
            return false
        }
        textField.resignFirstResponder()
        presenter?.searchButtonTapped(with: textField.text ?? "")
        return true
    }
}

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchResultCell
        
        let products = products[indexPath.row]
        cell.configure(withImageURL: products.thumbnail, text: products.title ?? "")
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
            cell.addGestureRecognizer(tapGesture)
            cell.tag = indexPath.row // Asignar el índice de la fila como tag para identificar la celda
           
        return cell
    }
    
    @objc func cellTapped(_ sender: UITapGestureRecognizer) {
        guard let cell = sender.view as? UITableViewCell else { return }
        let indexPath = IndexPath(row: cell.tag, section: 0)
        tableView(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        presenter?.didSelectRow(withProduct: product.id ?? "", at: indexPath)
    }
}
