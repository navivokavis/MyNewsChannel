//
//  NewView.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 25.10.22.
//

import UIKit

class SplashView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var backgroundImage = UIImageView()
    var mainTextImage = UIImageView()
    var smallTextImage = UIImageView()
    
    func setup() {
        
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        
        mainTextImage.image = UIImage(named: "newschanel")
        mainTextImage.contentMode = .scaleAspectFit
        
        smallTextImage.image = UIImage(named: "appby")
        smallTextImage.contentMode = .scaleAspectFit
        
        self.addSubview(backgroundImage)
        self.addSubview(mainTextImage)
        self.addSubview(smallTextImage)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        mainTextImage.translatesAutoresizingMaskIntoConstraints = false
        mainTextImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        mainTextImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mainTextImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        mainTextImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        smallTextImage.translatesAutoresizingMaskIntoConstraints = false
        smallTextImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 300).isActive = true
        smallTextImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        smallTextImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        smallTextImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        mainTextImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        mainTextImage.alpha = 0
        
        smallTextImage.transform = CGAffineTransform(translationX: 0, y: 20)
        smallTextImage.alpha = 0
    
        UIView.animate(withDuration: 2) {
            self.mainTextImage.transform = .identity
            self.mainTextImage.alpha = 1
            self.smallTextImage.transform = .identity
            self.smallTextImage.alpha = 1
        }
        
    }
    
}
