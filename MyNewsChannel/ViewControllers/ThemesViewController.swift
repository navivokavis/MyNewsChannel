//
//  ThemesViewController.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 20.10.22.
//

import UIKit

class ThemesCell: UITableViewCell {
    
}

class ThemesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    let themeTableView = UITableView()
    var dataSource = ["Ukraine", "War", "Money", "Architecture", "Fashion", "Covid-19"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        themeTableView.delegate = self
        themeTableView.dataSource = self
        themeTableView.register(ThemesCell.self, forCellReuseIdentifier: "cell")
        
    }
    


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = dataSource[indexPath.row]
    
    return cell
}

}
