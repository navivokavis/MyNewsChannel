//
//  NewsTableViewCell.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 20.10.22.
//

import UIKit

class TopNewsTableViewCell: UITableViewCell {
    
    static let identifier = "TopNewsTableViewCell"
    private let newsTitleLabel = UILabel()
    private let newsSubtitleLabel = UILabel()
    private let newsImageView = UIImageView()
    private let colorLineView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsSubtitleLabel)
        contentView.addSubview(newsImageView)
        contentView.addSubview(colorLineView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        newsTitleLabel.numberOfLines = 0
        
        newsSubtitleLabel.font = .systemFont(ofSize: 17, weight: .light)
        newsSubtitleLabel.numberOfLines = 0
        
        newsImageView.backgroundColor = .secondarySystemBackground
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.clipsToBounds = true
        newsImageView.layer.cornerRadius = 10
        newsImageView.layer.masksToBounds = true
        
        colorLineView.backgroundColor = .black
        
//        colorLineView.translatesAutoresizingMaskIntoConstraints = false
//        colorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
//        colorLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
//        colorLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
//        colorLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        colorLineView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        newsImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        newsTitleLabel.rightAnchor.constraint(equalTo: newsImageView.leftAnchor, constant: -5).isActive = true
        newsTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        newsTitleLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        newsSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsSubtitleLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: -0) .isActive = true
        newsSubtitleLabel.rightAnchor.constraint(equalTo: newsImageView.leftAnchor, constant: -5).isActive = true
        newsSubtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        newsSubtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        newsSubtitleLabel.text = nil
        newsImageView.image = nil
    }
    
//    func configure(with viewModel: TopNewsTableViewCellViewModel) {
//        newsTitleLabel.text = viewModel.title
//        newsSubtitleLabel.text = viewModel.subtitle
//        
//        if let data = viewModel.imageData {
//            newsImageView.image = UIImage(data: data)
//        } else if let url = viewModel.imageURL {
//            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//                guard let data = data, error == nil else {
//                    return
//                }
//                viewModel.imageData = data
//                DispatchQueue.main.async {
//                    self?.newsImageView.image = UIImage(data: data)
//                }
//            }.resume()
//        }
//    }
    
}
