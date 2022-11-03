//
//  ImagesForTypesCollectionViewCell.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 29.10.22.
//

import UIKit

class ImagesForTypesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ImagesForTypesCollectionViewCell"
    private var iconImageView = UIImageView()
    var isSelectedCell: Bool = false {
        didSet {
            self.contentView.tintColor = isSelectedCell ? .black : .systemGray3
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iconImageView)
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(images: String) {
        iconImageView.image = UIImage(systemName: images)
        isSelectedCell = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 5
        iconImageView.frame = contentView.bounds
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
    }
    
}
