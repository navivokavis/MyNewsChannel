//
//  SearchViewController.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 23.10.22.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    public var completion: ((String) -> Void)?
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [Article]()
    var txt = ""
    var searchBar = UISearchBar()
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Search"
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.barStyle = .black
        //        navigationItem.titleView = searchBar
        
        searchBar.showsCancelButton = true
        //        searchBar.searchTextField.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        
        searchBar.becomeFirstResponder()
        
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        becomeFirstResponder()
        return true
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.txt = searchBar.searchTextField.text!
            self.completion?(self.txt)
        }
       
//        searhNewsByWord(title: txt)
        self.navigationController?.popViewController(animated: true)
    }
    
//    func searhNewsByWord(title: String) {
//        APICaller.shared.searchStories(title: title){ [weak self] result in
//
//            switch result {
//            case.success(let articles):
//                self?.articles = articles
//                self?.viewModels = articles.compactMap({
//                    NewsTableViewCellViewModel(
//                        title: $0.title,
//                        subtitle: $0.description ?? "No Description",
//                        imageURL: URL(string: $0.urlToImage ?? ""),//может сюда вставляется дефолтная картинка?
//                        published: $0.publishedAt
//                    )
//                })
//
//                DispatchQueue.main.async {
//                    print("HOGFKKERFOFKWOFKPWE!!!!!!!!!!!!!!2131231414")
//                    MainViewController().newsTableView.reloadData()
//                    MainViewController().title = "\(title) news"
//                    MainViewController().backbutton.customView?.isHidden = false
//                }
//
//            case.failure( let error ):
//                print("I have Error \(error)")
//            }
//        }
//    }
    
    
    
    
}
