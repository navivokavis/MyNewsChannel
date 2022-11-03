//
//  TypesTableViewCell.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 28.10.22.
//

import UIKit

class TypesTableViewCell: UITableViewCell {

    static let identifier = "TypesTableViewCell"
    var typeNameLabel = UILabel()
    var typeImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(typeNameLabel)
        contentView.addSubview(typeImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}
