//
//  SetingsViewController.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 28.10.22.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var typeTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Settings"
            typeTableView.register(TypesTableViewCell.self, forCellReuseIdentifier: TypesTableViewCell.identifier)
        typeTableView.delegate = self
        typeTableView.dataSource = self
        view.addSubview(typeTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        typeTableView.frame = view.bounds
    }
    
    
    
    //MARK: - TableView Delegate and DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWithTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TypesTableViewCell.identifier,
                for: indexPath)
            as? TypesTableViewCell else {
            fatalError()
        }
        
        cell.textLabel?.text = arrayWithTypes[indexPath.row].typeName
        cell.imageView?.image = UIImage(systemName: arrayWithTypes[indexPath.row].typeImage)
//        cell.configure(with:NewsType[indexPath.row])
        return cell
   
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { action, indexPath in
            arrayWithTypes.remove(at: indexPath.row)
            self.typeTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    return [deleteAction]
    }
    
    
    
}


