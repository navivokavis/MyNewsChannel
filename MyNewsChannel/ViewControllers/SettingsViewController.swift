//
//  SetingsViewController.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 28.10.22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var typeTableView = UITableView()
    var smallSettingsMenuButton = UIButton()
    var smallSettingsMenuView = UIView()
    var addTypeNewsButton = UIButton()
    var initialSettingsButton = UIButton()
    var changeLanguageButton = UIButton()
    var transparentView = UIView()
    var addTypeView = UIView()
    var addTypeLabel = UILabel()
    var addTypeTextField = UITextField()
    var collectionView : UICollectionView!
    var okButton = UIButton()
    var cancelButton = UIButton()
    var imagesArray: [String] = []
    
    var selectedIndexPath: IndexPath?
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        typeTableView.frame = view.bounds
    }
    
    func setup() {
        buildHierarchy()
        configureSubviews()
        layoutSubviews()
    }
    
    func buildHierarchy() {
        view.addSubview(typeTableView)
        view.addSubview(smallSettingsMenuButton)
        view.addSubview(smallSettingsMenuView)
        smallSettingsMenuView.addSubview(addTypeNewsButton)
        smallSettingsMenuView.addSubview(initialSettingsButton)
        smallSettingsMenuView.addSubview(changeLanguageButton)
        view.addSubview(addTypeView)
        addTypeView.addSubview(addTypeLabel)
        addTypeView.addSubview(addTypeTextField)
        addTypeView.addSubview(okButton)
        addTypeView.addSubview(cancelButton)
    }
    
    func configureSubviews() {
        view.backgroundColor = .white
        title = LocalizedString.SettingsPage.title
        
        typeTableView.register(TypesTableViewCell.self, forCellReuseIdentifier: TypesTableViewCell.identifier)
        typeTableView.delegate = self
        typeTableView.dataSource = self
        
        smallSettingsMenuButton.setImage(UIImage(systemName: "list.bullet.circle.fill"), for: .normal)
        smallSettingsMenuButton.backgroundColor = .systemBackground
        smallSettingsMenuButton.layer.cornerRadius = 30
        smallSettingsMenuButton.contentVerticalAlignment = .fill
        smallSettingsMenuButton.contentHorizontalAlignment = .fill
        smallSettingsMenuButton.imageView?.tintColor = .black
        smallSettingsMenuButton.addTarget(self, action: #selector(smallSettingsMenuTapped), for: .touchUpInside)
        
        smallSettingsMenuView.backgroundColor = .systemBackground
        smallSettingsMenuView.layer.borderWidth = 1
        smallSettingsMenuView.layer.borderColor = UIColor.systemGray5.cgColor
        smallSettingsMenuView.layer.cornerRadius = 20
        smallSettingsMenuView.alpha = 0
        smallSettingsMenuView.transform = CGAffineTransform(translationX: 20, y: 0)
        
        addTypeNewsButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        addTypeNewsButton.contentVerticalAlignment = .fill
        addTypeNewsButton.contentHorizontalAlignment = .fill
        addTypeNewsButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addTypeNewsButton.isEnabled = false
        addTypeNewsButton.imageView?.tintColor = .systemGray5
        
        initialSettingsButton.setImage(UIImage(systemName: "clock.arrow.circlepath"), for: .normal)
        initialSettingsButton.contentVerticalAlignment = .fill
        initialSettingsButton.contentHorizontalAlignment = .fill
        initialSettingsButton.isEnabled = false
        initialSettingsButton.imageView?.tintColor = .systemGray5
        initialSettingsButton.addTarget(self, action: #selector(initialSettingsButtonTapped), for: .touchUpInside)
        
        changeLanguageButton.setImage(UIImage(systemName: "globe"), for: .normal)
        changeLanguageButton.contentVerticalAlignment = .fill
        changeLanguageButton.contentHorizontalAlignment = .fill
        changeLanguageButton.imageView?.tintColor = .systemGray
        changeLanguageButton.addTarget(self, action: #selector(changeLanguageButtonTapped), for: .touchUpInside)
        
        addTypeView.backgroundColor = .systemBackground
        addTypeView.layer.cornerRadius = 20
        
        addTypeLabel.text = LocalizedString.SettingsPage.inputTextLabel
        addTypeLabel.textAlignment = .center
        
        addTypeTextField.backgroundColor = .systemGray5
        addTypeTextField.layer.cornerRadius = 5
        addTypeTextField.textAlignment = .center
        addTypeTextField.placeholder = LocalizedString.SettingsPage.inputTextField
        addTypeTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.addTypeTextField.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //        guard let collectionView = collectionView else { return }
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(ImagesForTypesCollectionViewCell.self,
                                forCellWithReuseIdentifier: ImagesForTypesCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = false
        
        okButton.backgroundColor = .systemGray3
        okButton.layer.cornerRadius = 10
        okButton.setTitle("ok", for: .normal)
        okButton.addTarget(self, action: #selector(addNewType), for: .touchUpInside)
        
        cancelButton.backgroundColor = .red
        cancelButton.layer.cornerRadius = 10
        cancelButton.setTitle("cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(removeTransparentView), for: .touchUpInside)
        
        imagesArray = Pictures.allCases.map { pictures in
            let name = pictures.image
            return name
        }
        
    }
    
    func layoutSubviews() {
        smallSettingsMenuButton.translatesAutoresizingMaskIntoConstraints = false
        smallSettingsMenuButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        smallSettingsMenuButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        smallSettingsMenuButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        smallSettingsMenuButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        smallSettingsMenuView.translatesAutoresizingMaskIntoConstraints = false
        smallSettingsMenuView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        smallSettingsMenuView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        smallSettingsMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        smallSettingsMenuView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90).isActive = true
        
        addTypeNewsButton.translatesAutoresizingMaskIntoConstraints = false
        addTypeNewsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addTypeNewsButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        addTypeNewsButton.bottomAnchor.constraint(equalTo: smallSettingsMenuView.bottomAnchor, constant: -5).isActive = true
        addTypeNewsButton.leftAnchor.constraint(equalTo: smallSettingsMenuView.leftAnchor, constant: 10).isActive = true
        
        initialSettingsButton.translatesAutoresizingMaskIntoConstraints = false
        initialSettingsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        initialSettingsButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        initialSettingsButton.bottomAnchor.constraint(equalTo: smallSettingsMenuView.bottomAnchor, constant: -5).isActive = true
        initialSettingsButton.leftAnchor.constraint(equalTo: addTypeNewsButton.rightAnchor, constant: 10).isActive = true
        
        changeLanguageButton.translatesAutoresizingMaskIntoConstraints = false
        changeLanguageButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        changeLanguageButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        changeLanguageButton.bottomAnchor.constraint(equalTo: smallSettingsMenuView.bottomAnchor, constant: -5).isActive = true
        changeLanguageButton.leftAnchor.constraint(equalTo: initialSettingsButton.rightAnchor, constant: 10).isActive = true
        
    }
    
    //MARK: - Constraint for view with input TextField and collectionView
    
    func ConstrainTransparendViewIsVisible() {
        
        addTypeView.translatesAutoresizingMaskIntoConstraints = false
        addTypeView.heightAnchor.constraint(equalToConstant: 360).isActive = true
        addTypeView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        addTypeView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        addTypeView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        addTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        addTypeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addTypeLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        addTypeLabel.centerXAnchor.constraint(equalTo: addTypeView.centerXAnchor, constant: 0).isActive = true
        addTypeLabel.bottomAnchor.constraint(equalTo: addTypeTextField.topAnchor, constant: -5).isActive = true
        
        addTypeTextField.translatesAutoresizingMaskIntoConstraints = false
        addTypeTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addTypeTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        addTypeTextField.centerXAnchor.constraint(equalTo: addTypeView.centerXAnchor, constant: 0).isActive = true
        addTypeTextField.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: 290).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: addTypeView.centerXAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -20).isActive = true
        
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        okButton.rightAnchor.constraint(equalTo: addTypeView.rightAnchor, constant: -40).isActive = true
        okButton.bottomAnchor.constraint(equalTo: addTypeView.bottomAnchor, constant: -10).isActive = true
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: addTypeView.leftAnchor, constant: 40).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: addTypeView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    //MARK: - Check Active Button
    func changeColorAndActivityOfButton() {
        if arrayWithTypes.count < 11 {
            addTypeNewsButton.isEnabled = true
            addTypeNewsButton.imageView?.tintColor = .systemGreen
            initialSettingsButton.isEnabled = true
            initialSettingsButton.imageView?.tintColor = .systemBlue
            
        } else {
            addTypeNewsButton.isEnabled = false
            addTypeNewsButton.imageView?.tintColor = .systemFill
            initialSettingsButton.isEnabled = false
            initialSettingsButton.imageView?.tintColor = .systemFill
        }
    }
    
    //MARK: - Transperend View with input TextField and collectionView
    
    func addTransparentView() {
        view.addSubview(transparentView)
        view.addSubview(addTypeView)
        addTypeView.addSubview(collectionView)
        
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        transparentView.alpha = 0
        transparentView.backgroundColor = .black
        
        addTypeView.layer.cornerRadius = 5
        
        ConstrainTransparendViewIsVisible()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        
        UIView.transition(with: addTypeView, duration: 0.2) {
            self.transparentView.alpha = 0.5
            self.addTypeView.alpha = 1
        }
    }
    
    @objc func removeTransparentView() {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.addTypeView.alpha = 0
            
        }, completion: nil)
    }
    
    //MARK: - @objc functions Small Settings Menu
    
    
    
    @objc func smallSettingsMenuTapped() {
        changeColorAndActivityOfButton()
        self.smallSettingsMenuView.alpha == 0 ?
        UIView.transition(with: smallSettingsMenuView, duration: 0.3) {
            self.smallSettingsMenuView.alpha = 1
            self.smallSettingsMenuView.transform = CGAffineTransform(translationX: 0, y: 0)
        } : UIView.transition(with: smallSettingsMenuView, duration: 0.3) {
            self.smallSettingsMenuView.alpha = 0
            self.smallSettingsMenuView.transform = CGAffineTransform(translationX: 20, y: 0)
        }
        //choice image in collection view dont work
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        
        // это свойство не распространяется на другие вью
        tapGestureRecognizer.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func backgroundTapped() {
        UIView.transition(with: view, duration: 0.3) {
            self.smallSettingsMenuView.alpha = 0
            self.smallSettingsMenuView.transform = CGAffineTransform(translationX: 20, y: 0)
        }
    }
    
    //MARK: - @objc functions add Button
    
    @objc func addButtonTapped() {
        addTransparentView()
    }
    
    //MARK: - @objc functions initial settings Button
    
    @objc func initialSettingsButtonTapped() {
        arrayWithTypes.removeAll()
        arrayWithTypes = NewsType.allCases.map({ type in
            return TypeFor.init(typeName: NewsType.getTitleFor(title: type), typeImage: type.systemName)
        })
        UserDefaultsModel.saveArray(arrayWithTypes)
        typeTableView.reloadData()
        changeColorAndActivityOfButton()
    }
    
    //MARK: - @objc functions Change Language Button
    
    @objc func changeLanguageButtonTapped() {
        //        let languageViewController = LanguageViewController()
        //        languageViewController.transitioningDelegate  = languageViewController.overlayTransitioningDelegate
        //        languageViewController.modalPresentationStyle = .custom
        //        self.present(languageViewController, animated: true, completion: nil)
        
        //open phone settings
        if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
            UIApplication.shared.open(appSettings)
        }
    }
    
    //MARK: - @objc functions text change check
    
    @objc func textDidChange() {
        guard let text = addTypeTextField.text,
              selectedImage != nil else { return }
        okButton.backgroundColor = text.count > 2 ? .green : .systemGray3
        okButton.isEnabled = text.count > 2 ? true : false
    }
    
    //MARK: - @objc functions add new Category
    
    @objc func addNewType() {
        if let text = addTypeTextField.text,
           text != "",
           let index = selectedIndexPath,
           let image = selectedImage {
            let typeStruct = TypeFor(typeName: text, typeImage: image)
            arrayWithTypes.append(typeStruct)
            UserDefaultsModel.saveArray(arrayWithTypes)
            typeTableView.reloadData()
            removeTransparentView()
            
            addTypeTextField.text = ""
            let cell = collectionView.cellForItem(at: index)
            cell?.contentView.tintColor = .systemGray3
            selectedIndexPath = nil
            
            textDidChange()
            selectedImage = nil
            changeColorAndActivityOfButton()
        }
    }
    
}

//MARK: - TableView Delegate and DataSource

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
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
        cell.imageView?.tintColor = .black
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
            UserDefaultsModel.saveArray(arrayWithTypes)
            self.typeTableView.deleteRows(at: [indexPath], with: .automatic)
            self.changeColorAndActivityOfButton()
        }
        return [deleteAction]
    }
}

//MARK: - Collerction View Delegate and DataSource

extension SettingsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Pictures.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesForTypesCollectionViewCell.identifier, for: indexPath) as! ImagesForTypesCollectionViewCell
        
        cell.setup(images: imagesArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! ImagesForTypesCollectionViewCell
        cell.isSelectedCell = !cell.isSelectedCell
        //        imagesArray[indexPath.row]
        
        // метод при котором может быть только 1 элемент коллекшен Вью
        self.selectedIndexPath = indexPath
        selectedImage = imagesArray[indexPath.row]
        if self.selectedIndexPath != nil && indexPath == self.selectedIndexPath {
            cell.contentView.tintColor = .black
        } else {
            cell.contentView.tintColor = .systemGray3
        }
        
        textDidChange()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImagesForTypesCollectionViewCell
        
        // метод при котором может быть только 1 элемент коллекшен Вью
        self.selectedIndexPath = nil
        selectedImage = nil
        if self.selectedIndexPath != nil && indexPath == self.selectedIndexPath {
            cell.contentView.tintColor = .black
        } else {
            cell.contentView.tintColor = .systemGray3
        }
        
        textDidChange()
    }
    
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.addTypeTextField.endEditing(true)
            return false
        }
}
