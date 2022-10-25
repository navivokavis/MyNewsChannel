//
//  ViewController.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 18.10.22.
//

import UIKit
import SafariServices


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let newsTableView = UITableView()
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [Article]()
    var searchRightButton = UIBarButtonItem()
    var lineLeftButton = UIBarButtonItem()
    var backbutton = UIBarButtonItem()
    let darkBacgroundView = UIView()
    let transparentView = ThemesView()
    //    let themeTableView = UITableView()
    //    var dataSource = [String]()
    let vc = SearchViewController()
    
    //создаю меню
    var categoryMenu: UIMenu {
        let menuActions = NewsType.allCases.map({ (item) -> UIAction in
            let name = item.rawValue
            return UIAction(title: name.capitalized, image: UIImage(systemName: item.systemName)) { (_) in
                self.categoryMenu.image?.withTintColor(.white, renderingMode: .alwaysTemplate)
                self.searhNewsByType(type: item)
            }
        })
        return UIMenu(title: "Change Category", children: menuActions)
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        present(SplashViewController(), animated: true)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        vc.completion = { [weak self] text in
            guard let self = self else { return }
                    self.searhNewsByWord(title: text)
                    print("!@UASKLFHASOKFJASLKFHJASLJDHWJKQGEOI!EH(IUOPHNASLJKFH")
                }
    }
    
    func setup() {
        buildHierarchy()
        configureSubviews()
        layoutSubviews()
    }
    
    func buildHierarchy() {
        view.addSubview(newsTableView)
    }
    
    func configureSubviews() {
        title = "Top Rated News"
        
        self.navigationController?.setupNavigationController()
        self.navigationController!.navigationBar.tintColor = .white
        
        searchRightButton = createCustomBarButton(imageName: "magnifyingglass", selector: #selector(searchRightButtonTapped))
        lineLeftButton = UIBarButtonItem(systemItem: .bookmarks, primaryAction: nil, menu: categoryMenu)
        backbutton = createCustomBarButton(imageName: "arrowshape.turn.up.backward", selector: #selector(backbuttonTapped))
        
        navigationItem.rightBarButtonItem = searchRightButton
        navigationItem.leftBarButtonItems = [lineLeftButton, backbutton]
        backbutton.customView?.isHidden = true
        
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        APICaller.shared.getTopStories{ [weak self] result in
            switch result {
            case.success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? ""),
                        published: $0.publishedAt
                    )
                })
                
                DispatchQueue.main.async {
                    self?.newsTableView.reloadData()
                }
                
            case.failure( let error ):
                print("I have Error \(error)")
            }
        }
        
       
    }
    
//    func addTransparentView() {
//        let window = UIApplication.shared.keyWindow
//        darkBacgroundView.frame = window?.frame ?? self.view.frame
//        view.addSubview(darkBacgroundView)
//
//        transparentView.frame = CGRect(x: 0, y: 150, width: 300, height: 0)
//        view.addSubview(transparentView)
//        transparentView.layer.cornerRadius = 20
//
//        darkBacgroundView.backgroundColor = .black.withAlphaComponent(0.9)
//
//        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
//        darkBacgroundView.addGestureRecognizer(tapgesture)
//        darkBacgroundView.alpha = 0
//        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
//            self.darkBacgroundView.alpha = 0.5
//            self.transparentView.frame = CGRect(x: 20, y: 150, width: 300, height: CGFloat(self.transparentView.dataSource.count * 40))
//            self.transparentView.alpha = 0.9
//        }, completion: nil)
//
//        // здесь я реализую замыкания
//        transparentView.typeSelect = { [weak self] type in
//            print(type)
//            self?.searhNewsByType(type: type)
//            self!.removeTransparentView()
//        }
//    }
//
//    @objc func removeTransparentView() {
//        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
//            self.darkBacgroundView.alpha = 0
//            self.transparentView.frame = CGRect(x: 20, y: 150, width: 300, height: 0)
//        }, completion: nil)
//    }
    
    
    
    func layoutSubviews() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsTableView.frame = view.bounds
    }
    
    
    //MARK: - Search Button Tapped
    @objc func searchRightButtonTapped() {
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
        
        //здерь реализован метод поиска через ALERT CONTROLLER
        
        //        presentSearchAlertController(withTitle: "Search", message: "with keyword", style: .alert) { [weak self] keyWord in
        //            APICaller.shared.searchStories(title: keyWord){ [weak self] result in
        //
        //                switch result {
        //                case.success(let articles):
        //                    self?.articles = articles
        //                    self?.viewModels = articles.compactMap({
        //                        NewsTableViewCellViewModel(
        //                            title: $0.title,
        //                            subtitle: $0.description ?? "No Description",
        //                            imageURL: URL(string: $0.urlToImage ?? ""),//может сюда вставляется дефолтная картинка?
        //                            published: $0.publishedAt
        //                        )
        //                    })
        //
        //                    DispatchQueue.main.async { [self]
        //                        self?.newsTableView.reloadData()
        //                        self?.title = "News with '\(keyWord)'"
        //                        self?.backbutton.customView?.isHidden = false
        //                    }
        //                case.failure( let error ):
        //                    print("I have Error \(error)")
        //                }
        //            }
        //        }
    }
    
    func searhNewsByWord(title: String) {
        
        APICaller.shared.searchStories(title: title){ [weak self] result in
            switch result {
            case.success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? ""),//может сюда вставляется дефолтная картинка?
                        published: $0.publishedAt
                    )
                })
                
                DispatchQueue.main.async {
                    print("-123ggg------------HOGFKKERFOFKWOFKPWE!!!!!!!!!!!!!!2131231414")
                    self?.newsTableView.reloadData()
                    self?.title = "\(title) news"
                    self?.backbutton.customView?.isHidden = false
                }
                
            case.failure( let error ):
                print("I have Error \(error)")
            }
        }
    }
    
    func searhNewsByType(type: NewsType) {
        APICaller.shared.searchStories(title: type.rawValue){ [weak self] result in
            
            switch result {
            case.success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? ""),//может сюда вставляется дефолтная картинка?
                        published: $0.publishedAt
                    )
                })
                
                DispatchQueue.main.async {
                    self?.newsTableView.reloadData()
                    self?.title = "\(type.rawValue) news"
                    self?.backbutton.customView?.isHidden = false
                }
                
            case.failure( let error ):
                print("I have Error \(error)")
            }
        }
    }
    
    @objc func lineLeftButtonTapped() {
        //        addTransparentView()
    }
    
    @objc func backbuttonTapped() {
        
        APICaller.shared.getTopStories{ [weak self] result in
            switch result {
            case.success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? ""),
                        published: $0.publishedAt
                    )
                })
                
                DispatchQueue.main.async {
                    self?.newsTableView.reloadData()
                    self?.backbutton.customView?.isHidden = true
                    self?.title = "Top Rated News"
                    
                }
                
            case.failure( let error ):
                print("I have Error \(error)")
            }
        }
    }
    
    
    
    
    //MARK: - TableView Delegate and DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.identifier,
            for: indexPath)
                as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with:viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
}
