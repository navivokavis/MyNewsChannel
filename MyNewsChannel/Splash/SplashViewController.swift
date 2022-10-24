//
//  SplashViewController.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 22.10.22.
//

import UIKit

class SplashViewController: UIViewController {

    var backgroundImage = UIImageView()
    var mainTextImage = UIImageView()
    var smallTextImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        
        mainTextImage.image = UIImage(named: "newschanel")
        mainTextImage.contentMode = .scaleAspectFit
        
        smallTextImage.image = UIImage(named: "appby")
        smallTextImage.contentMode = .scaleAspectFit

        view.addSubview(backgroundImage)
        view.addSubview(mainTextImage)
        view.addSubview(smallTextImage)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mainTextImage.translatesAutoresizingMaskIntoConstraints = false
        mainTextImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainTextImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainTextImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        mainTextImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        smallTextImage.translatesAutoresizingMaskIntoConstraints = false
        smallTextImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 300).isActive = true
        smallTextImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        smallTextImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        smallTextImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
       
        
        mainTextImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        mainTextImage.alpha = 0
        
        smallTextImage.transform = CGAffineTransform(translationX: 0, y: 20)
        smallTextImage.alpha = 0

        UIView.animate(withDuration: 2) {
            self.mainTextImage.transform = .identity
            self.mainTextImage.alpha = 1
        }
        
        UIView.animate(withDuration: 2) {
            self.smallTextImage.transform = .identity
            self.smallTextImage.alpha = 1
        }

    }
    



}
