//
//  Extension.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 18.10.22.
//

import UIKit

//MARK: - Create Custom NavigationController
extension UINavigationController {
    
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
 
    func setupNavigationController() {
        self.navigationBar.backgroundColor = .black
        self.navigationBar.barTintColor = .black
        self.navigationBar.barStyle = UIBarStyle.default
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.setStatusBar(backgroundColor: .black)
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}

extension UIViewController {
    
    //MARK: - Create Custom Navigation Bar
    func createCustomBarButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let customButton = UIButton(type: .system)
        customButton.setImage(
            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        customButton.tintColor = .white
        customButton.imageView?.contentMode = .scaleAspectFit
        customButton.contentVerticalAlignment = .fill
        customButton.contentHorizontalAlignment = .fill
        customButton.addTarget(self, action: selector, for: .touchUpInside)
        
        let customBarButton = UIBarButtonItem(customView: customButton )
        
        return customBarButton
    }
  
}

//MARK: - Create alert controller
extension MainViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        let aletrController = UIAlertController(title: title, message: message, preferredStyle: style)
        aletrController.addTextField()
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = aletrController.textFields?.first
            guard let keyWord = textField?.text else { return }
            if keyWord != "" {
                let key = keyWord.split(separator: " ").joined(separator: "%20")
                completionHandler(key)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        aletrController.addAction(search)
        aletrController.addAction(cancel)
        present(aletrController, animated: true)
        
        
        
        
    }
}
