//
//  ThemesView.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 21.10.22.
//

import UIKit

let themeTableView = UITableView()
var dataSource = ["Ukraine", "War", "Money", "Architecture", "Fashion", "Covid-19"]


class ThemesView: UIView {
    
    
    goIt()
    
    func goIt() {
    themeTableView.delegate = self
    themeTableView.dataSource = self
    themeTableView.register(ThemesCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ThemesView: UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    <#code#>
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    <#code#>
}

    
}
