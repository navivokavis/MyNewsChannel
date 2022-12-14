//
//  ViewController.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 18.10.22.
// This project remade with RxSwift on 27.11.2022

import UIKit
import SafariServices

class MainViewController: UIViewController {
    
    let newsTableView = UITableView()
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [Article]()
    var searchRightButton = UIBarButtonItem()
    var menuLeftButton = UIBarButtonItem()
    var backbutton = UIBarButtonItem()
    var setingsButton = UIBarButtonItem()
    var splashView = SplashView()
    var refresh = UIRefreshControl()
    
    //Create UIMenu with ENUM
    //    var categoryMenu: UIMenu {
    //        let menuActions = NewsType.allCases.map({ (item) -> UIAction in
    //            let name = item.rawValue
    //            return UIAction(title: name.capitalized, image: UIImage(systemName: item.systemName)) { (_) in
    //                self.categoryMenu.image?.withTintColor(.white, renderingMode: .alwaysTemplate)
    //                self.searhNewsByType(type: item)
    //            }
    //        })
    //        return UIMenu(title: "Change Category", children: menuActions)
    //    }
    
    //Create UIMenu with ARRAY
    //    var categoryMenu: UIMenu {
    //        var menuActions: [UIAction] = []
    //        for type in arrayWithTypes {
    //            let action = UIAction(title: type.typeName.capitalized, image: UIImage(systemName: type.typeImage)) { (_) in
    //                self.categoryMenu.image?.withTintColor(.white, renderingMode: .alwaysTemplate)
    //                self.searhNewsByType(type: type.typeName)
    //            }
    //            menuActions.append(action)
    //        }
    //        return UIMenu(title: "Change Category", children: menuActions)
    //    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        menuLeftButton.menu = setupUIMenu()
        apicaller()
        title = LocalizedString.MainPage.title
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        buildHierarchy()
        configureSubviews()
        layoutSubviews()
    }
    
    func buildHierarchy() {
        view.addSubview(newsTableView)
        view.addSubview(splashView)
        newsTableView.addSubview(refresh)
    }
    
    func configureSubviews() {
        
        self.navigationController?.setupNavigationController()
        self.navigationController?.setupNavigationMultilineTitle()
        self.navigationController!.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.alpha = 0
        
        self.refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        setingsButton = createCustomBarButton(imageName: "square.and.pencil", selector: #selector(setingsButtonTapped))
        searchRightButton = createCustomBarButton(imageName: "magnifyingglass", selector: #selector(searchRightButtonTapped))
        menuLeftButton = UIBarButtonItem(systemItem: .bookmarks, primaryAction: nil, menu: setupUIMenu())
        backbutton = createCustomBarButton(imageName: "arrowshape.turn.up.backward", selector: #selector(backbuttonTapped))
        
        navigationItem.rightBarButtonItems = [searchRightButton, setingsButton]
        navigationItem.leftBarButtonItems = [menuLeftButton, backbutton]
        backbutton.customView?.isHidden = true
        
        newsTableView.register(FirstNewsTableViewCell.self, forCellReuseIdentifier: FirstNewsTableViewCell.identifier)
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        UIView.animate(withDuration: 1, delay: 2.5) {
            self.splashView.alpha = 0
            self.navigationController?.navigationBar.alpha = 1
        }
    }
    
    func layoutSubviews() {
        splashView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        splashView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        splashView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        splashView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsTableView.frame = view.bounds
    }
    
    //MARK: - API CALLER
    
    func apicaller() {
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
    
    //MARK: - Create Menu
    
    func setupUIMenu() -> UIMenu {
        let menu = UIMenu()
        var menuActions: [UIAction] = []
        for type in arrayWithTypes {
            let action = UIAction(title: type.typeName.capitalized, image: UIImage(systemName: type.typeImage)) { (_) in
                menu.image?.withTintColor(.white, renderingMode: .alwaysTemplate)
                self.searhNewsByType(type: type.typeName)
            }
            menuActions.append(action)
        }
        return UIMenu(title: LocalizedString.UIMenu.titleMenu, children: menuActions)
    }
    
    //MARK: - Handle Refresh
    
    @objc func handleRefresh() {
        apicaller()
        newsTableView.reloadData()
        refresh.endRefreshing()
    }
    
    //MARK: - Setings Button Tapped
    
    @objc func setingsButtonTapped() {
        let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Search Button Tapped
    
    @objc func searchRightButtonTapped() {
        let vc = SearchViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.completion = { [weak self] text in
            guard let self = self else { return }
            self.searhNewsByWord(title: text)
        }
        // here is metod with ALERT CONTROLLER
        
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
        //                            imageURL: URL(string: $0.urlToImage ?? ""),
        //                            published: $0.publishedAt
        //                        )
        //                    })
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
    
    //MARK: - Back Button Tapped
    
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
                    self?.title = LocalizedString.MainPage.title
                }
            case.failure( let error ):
                print("I have Error \(error)")
            }
        }
    }
    
    //MARK: - Search functions
    
    func searhNewsByWord(title: String) {
        APICaller.shared.searchStories(title: title){ [weak self] result in
            switch result {
            case.success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? ""),//?????????? ???????? ?????????????????????? ?????????????????? ?????????????????
                        published: $0.publishedAt
                    )
                })
                DispatchQueue.main.async {
                    self?.newsTableView.reloadData()
                    self?.title = "\(title) \(LocalizedString.MainPage.newsWithCategory)"
                    self?.backbutton.customView?.isHidden = false
                }
            case.failure( let error ):
                print("I have Error \(error)")
            }
        }
    }
    
    func searhNewsByType(type: String) {
        APICaller.shared.searchStories(title: type){ [weak self] result in
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
                    self?.title = "\(type) \(LocalizedString.MainPage.newsWithCategory)"
                    self?.backbutton.customView?.isHidden = false
                }
            case.failure( let error ):
                print("I have Error \(error)")
            }
        }
    }
}


//MARK: - TableView Delegate and DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FirstNewsTableViewCell.identifier,
                for: indexPath)
                    as? FirstNewsTableViewCell else {
                fatalError()
            }
            cell.configure(with:viewModels[indexPath.row])
            return cell
        }
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
        var heightForRow: CGFloat = 0
        if indexPath.row == 0 {
            heightForRow = 350
        }
        if indexPath.row >= 1 {
            heightForRow = 150
        }
        return heightForRow
    }
    
}

extension UIViewController {
    
//    func setupNavigationMultilineTitle() {
//        guard let navigationBar = self.navigationController?.navigationBar else { return }
//        for sview in navigationBar.subviews {
//            for ssview in sview.subviews {
//                guard let label = ssview as? UILabel else { break }
//                if label.text == self.title {
//                    label.numberOfLines = 0
//                    label.lineBreakMode = .byWordWrapping
//                    label.sizeToFit()
//                    UIView.animate(withDuration: 0.3, animations: {
//                        navigationBar.frame.size.height = 57 + label.frame.height
//                    })
//                }
//            }
//        }
//    }
}

