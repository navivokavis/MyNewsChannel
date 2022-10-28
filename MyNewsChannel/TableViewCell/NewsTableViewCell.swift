//
//  NewsTableViewCell.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 18.10.22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    private let newsTitleLabel = UILabel()
    private let newsImageView = UIImageView()
    private let colorLineView = UIView()
    private let publishedDateLabel = UILabel()
//    var currentPublishedDate = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsImageView)
        contentView.addSubview(colorLineView)
        contentView.addSubview(publishedDateLabel)
        contentView.addSubview(newsTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        newsTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        newsTitleLabel.numberOfLines = 0
        newsTitleLabel.textColor = .black
        
        newsImageView.backgroundColor = .secondarySystemBackground
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.clipsToBounds = true
        newsImageView.layer.cornerRadius = 10
        newsImageView.layer.masksToBounds = true
        
        colorLineView.backgroundColor = .black
        
        publishedDateLabel.font = .systemFont(ofSize: 12, weight: .light)
        publishedDateLabel.textColor = .gray
        publishedDateLabel.numberOfLines = 0
        
        
        //MARK: - Constraint
        colorLineView.translatesAutoresizingMaskIntoConstraints = false
        colorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        colorLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        colorLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        colorLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        newsImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        newsTitleLabel.bottomAnchor.constraint(equalTo: publishedDateLabel.topAnchor, constant: -10).isActive = true
        newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        newsTitleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -5).isActive = true
        
        publishedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        publishedDateLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        publishedDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        publishedDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        publishedDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        publishedDateLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        newsImageView.image = UIImage(named: "loadImg")
        publishedDateLabel.text = nil
    }
    
    func convertDateToString(stringDate: String) -> String {
        
        let formatter: ISO8601DateFormatter = .init()
        
        let rawDate = formatter.date(from: stringDate)
        
        let form: DateFormatter = .init()
        form.dateFormat = "yyyy MMM dd HH:mm"
        
        let finalString = form.string(from: rawDate!)
        
        return finalString
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
//        publishedDateLabel.text = viewModel.published
        publishedDateLabel.text = convertDateToString(stringDate: viewModel.published)
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
//                    self?.newsImageView.image = UIImage(named: "NVNEWS")
                    self?.newsImageView.image = UIImage(data: data)
                }
                
                
            }
            .resume()
        }
//        func doCurrentPublishedDate(date: String) -> String {
//            for i in viewModel.published {
//                let arrayOfElements = i
//
//                print("THIS!!!!! \(arrayOfElements)")
//
//            }
//            return doCurrentPublishedDate(date: viewModel.published)
//            //        currentPublishedDate
//        }
//        doCurrentPublishedDate(date: viewModel.published)
    }
    
}
