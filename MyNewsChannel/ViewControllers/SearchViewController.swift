//
//  SearchViewController.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 23.10.22.
//

import UIKit

class SearchViewController: UIViewController {
    
    // объявил замыкание
    public var completion: ((String) -> Void)?
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [Article]()
    var txt = ""
    var searchBar = UISearchBar()
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = LocalizedString.SearchPage.title
//        title = defaultLocalizer.stringForKey(key: "Search")
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.barStyle = .black
        
        searchController.searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
    }
}

//MARK: - SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        becomeFirstResponder()
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // отправляю замыкание
        self.txt = searchBar.searchTextField.text!
        self.completion?(self.txt)
        self.navigationController?.popViewController(animated: true)
    }
}
