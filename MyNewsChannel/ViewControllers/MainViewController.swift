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
    var backbutton = UIBarButtonItem()
    
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
    }
    
    func configureSubviews() {
        title = "Top Rated News"
        
        view.backgroundColor = .systemBackground
        
        self.navigationController?.setupNavigationController()
        
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
//        newsTableView.register(TopNewsTableViewCell.self, forCellReuseIdentifier: TopNewsTableViewCell.identifier)

        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        let searchRightButton = createCustomBarButton(imageName: "magnifyingglass", selector: #selector(searchRightButtonTapped))
        let lineLeftButton = createCustomBarButton(imageName: "line.3.horizontal", selector: #selector(lineLeftButtonTapped))
        backbutton = createCustomBarButton(imageName: "arrowshape.turn.up.backward", selector: #selector(backbuttonTapped))
        
        navigationItem.rightBarButtonItem = searchRightButton
        navigationItem.leftBarButtonItems = [lineLeftButton, backbutton]
        backbutton.customView?.isHidden = true
        
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
    
    func layoutSubviews() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsTableView.frame = view.bounds
    }
    
    
    //MARK: - selector button tapped
    @objc func searchRightButtonTapped() {
        presentSearchAlertController(withTitle: "Search", message: "with keyword", style: .alert) { [weak self] keyWord in
            APICaller.shared.searchStories(title: keyWord){ [weak self] result in
                
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
                    
                    DispatchQueue.main.async { [self]
                        self?.newsTableView.reloadData()
                        self?.title = "News with '\(keyWord)'"
                        self?.backbutton.customView?.isHidden = false
                    }
                    
                case.failure( let error ):
                    print("I have Error \(error)")
                }
            }

            
    }
    }
    
    @objc func lineLeftButtonTapped() {
        print("lineLeftButtonTapped")
    }
    
    @objc func backbuttonTapped() {
        print("backbuttonTapped")
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
//        switch indexPath.section {
//    case 0:
//        let cell = tableView.dequeueReusableCell(withIdentifier: TopNewsTableViewCell.identifier) as! TopNewsTableViewCell
////        let article = itemsTop[indexPath.row]
////        cell.load(article: article)
//            cell.load(TopNewsTableViewCell)
//        return cell
//    case 1:
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier) as! NewsTableViewCell
//        cell.load(NewsTableViewCell)
//        return cell
//    default:
//        let cell = tableView.dequeueReusableCell(withIdentifier: AppleNewsCell.identifier) as! AppleNewsCell
//        let article = items[indexPath.row]
//        cell.load(article: article)
//        return cell
//        }
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
