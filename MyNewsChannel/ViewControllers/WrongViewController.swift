//
//  WrongViewController.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 27.10.22.
//

import UIKit

class WrongViewController: UIViewController {

    var wrongLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wrongLabel.text = "Sorry /n something wrong...."
        wrongLabel.textAlignment = .center
        wrongLabel.numberOfLines = 0
        wrongLabel.font = .systemFont(ofSize: 30, weight: .bold)
        wrongLabel.bounds = view.bounds
    }
    


}
