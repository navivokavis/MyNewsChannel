//
//  LanguageViewController.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 1.11.22.
//

import UIKit

//MARK: - This page is mute and don't work, because language changed in phone settings

class LanguageViewController: UIViewController {
    
    let overlayTransitioningDelegate = OverlayTransitioningDelegate()
    //    let overlayPresentationController = OverlayPresentationController()
    var languagePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        buildHierarchy()
        configureSubviews()
        layoutSubviews()
    }
    
    func buildHierarchy() {
        view.addSubview(languagePickerView)
    }
    
    func configureSubviews() {
        view.backgroundColor = .systemBackground
        
        languagePickerView.dataSource = self
        languagePickerView.delegate = self
        
        createToolBar()
    }
    
    func layoutSubviews() {
        languagePickerView.translatesAutoresizingMaskIntoConstraints = false
        languagePickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        languagePickerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        languagePickerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    func createToolBar() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: defaultLocalizer.stringForKey(key: "Done"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneButtonTapped))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([space, doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        toolbar.barTintColor = .systemBackground
        toolbar.tintColor = .black
        
        view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        toolbar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        toolbar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        toolbar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    @objc func doneButtonTapped() {
        self.dismiss(animated: true)
        
    }
    
    
}

extension LanguageViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var rowText = ""
        switch row {
        case 0:
            rowText = "Русский"
        case 1:
            rowText = "English"
        case 2:
            rowText = "Español"
        case 3:
            rowText = "Italiano"
        default:
            break
        }
        return rowText
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            defaultLocalizer.setSelectedLanguage(lang: "ru")
            symbolsOfLanguage = "ru"
        case 1:
            defaultLocalizer.setSelectedLanguage(lang: "en")
            symbolsOfLanguage = "en"
        case 2:
            defaultLocalizer.setSelectedLanguage(lang: "es")
            symbolsOfLanguage = "es"
        case 3:
            defaultLocalizer.setSelectedLanguage(lang: "it")
            symbolsOfLanguage = "it"
        default:
            break
        }
        print(symbolsOfLanguage)
        
    }
    
}


class OverlayTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    internal func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return OverlayPresentationController(presentedViewController:presented, presenting:presenting)
    }
    
}

class OverlayPresentationController: UIPresentationController {
    
    private let dimmedBackgroundView = UIView()
    private let height: CGFloat = 300.0
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        self.dimmedBackgroundView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame =  CGRect.zero
        if let containerBounds = containerView?.bounds {
            frame = CGRect(x: 0,
                           y: containerBounds.height - height,
                           width: containerBounds.width,
                           height: height)
        }
        return frame
    }
    
    override func presentationTransitionWillBegin() {
        if let containerView = self.containerView, let coordinator = presentingViewController.transitionCoordinator {
            containerView.addSubview(self.dimmedBackgroundView)
            self.dimmedBackgroundView.backgroundColor = .black
            self.dimmedBackgroundView.frame = containerView.bounds
            self.dimmedBackgroundView.alpha = 0
            coordinator.animate(alongsideTransition: { _ in
                self.dimmedBackgroundView.alpha = 0.5
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        self.dimmedBackgroundView.removeFromSuperview()
    }
    
    @objc private func backgroundTapped() {
        
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    
}

