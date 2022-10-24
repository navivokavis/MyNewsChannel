//
//  ThemesView.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 21.10.22.
//

import UIKit

class ThemesCell: UITableViewCell {
    
}

enum NewsType: String, CaseIterable {
    case ukraine = "Ukraine"
    case war = "War"
    case business = "Business"
    case entertainment = "Entertainment"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case architecture = "Architecture"
    case fashion = "Fashion"
    case technology = "Technology"
    case covid = "Covid-19"
    
    var systemName: String {
        switch self {
        case .ukraine:
            return "bolt.fill"
        case .war:
            return "multiply.square.fill"
        case .business:
            return "briefcase"
        case .entertainment:
            return "film"
        case .health:
            return "stethoscope"
        case .science:
            return "function"
        case .sports:
            return "sportscourt"
        case .architecture:
            return "building.2"
        case .technology:
            return "gear"
        case .fashion:
            return "crown"
        case .covid:
            return "stethoscope"
        }
    }
}
                    
                    
                    
class ThemesView: UIView {
    
    let themeTableView = UITableView()
    var dataSource: [NewsType] = [.ukraine, .war, .business, .entertainment, .health, .science, .sports, .architecture, .fashion, .technology, .covid]
    
// здесь я объявляю замыкания
    var typeSelect: ((NewsType) -> Void)?
    
    
    func setup() {
//        buildHierarchy()
//        configureSubviews()
        
        themeTableView.delegate = self
        themeTableView.dataSource = self
        themeTableView.register(ThemesCell.self, forCellReuseIdentifier: "cell")
        addSubview(themeTableView)
//        backgroundColor = .red
        layoutSubviews()
//        ThemesView().addSubview(themeTableView)
    }
    
    override func layoutSubviews() {
        themeTableView.translatesAutoresizingMaskIntoConstraints = false
        themeTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        themeTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        themeTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        themeTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//func tpresentController () {
//    let vc = UkraineViewController()
//    present
//}

extension ThemesView: UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = dataSource[indexPath.row].rawValue
    
    return cell
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.row {
//        case 0:
//            print(1)
//
//        case 1:
//            print(1)
//        case 2:
//            print(2)
//        case 3:
//            print(3)
//        case 4:
//            print(4)
//        default:
//            break
//        }
        typeSelect?(dataSource[indexPath.row])
        
    }
    
}
