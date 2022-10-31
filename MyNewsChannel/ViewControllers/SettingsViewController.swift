//
//  SetingsViewController.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 28.10.22.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var typeTableView = UITableView()
    var tapToChangeButton = UIButton()
    var smallMenuToChangeView = UIView()
    var addTypeNewsButton = UIButton()
    var cancelChangesButton = UIButton()
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
        view.addSubview(tapToChangeButton)
        view.addSubview(smallMenuToChangeView)
        smallMenuToChangeView.addSubview(addTypeNewsButton)
        smallMenuToChangeView.addSubview(cancelChangesButton)
        smallMenuToChangeView.addSubview(changeLanguageButton)
        view.addSubview(addTypeView)
        addTypeView.addSubview(addTypeLabel)
        addTypeView.addSubview(addTypeTextField)
        addTypeView.addSubview(okButton)
        addTypeView.addSubview(cancelButton)
    }
    
    func configureSubviews() {
        view.backgroundColor = .white
        title = "Settings"
        
        typeTableView.register(TypesTableViewCell.self, forCellReuseIdentifier: TypesTableViewCell.identifier)
        typeTableView.delegate = self
        typeTableView.dataSource = self
        
        tapToChangeButton.setImage(UIImage(systemName: "list.bullet.circle.fill"), for: .normal)
        tapToChangeButton.backgroundColor = .systemBackground
        tapToChangeButton.layer.cornerRadius = 30
        tapToChangeButton.contentVerticalAlignment = .fill
        tapToChangeButton.contentHorizontalAlignment = .fill
        tapToChangeButton.imageView?.tintColor = .black
        tapToChangeButton.addTarget(self, action: #selector(systemButtonTapped), for: .touchUpInside)
        
        smallMenuToChangeView.backgroundColor = .systemBackground
        smallMenuToChangeView.layer.borderWidth = 1
        smallMenuToChangeView.layer.borderColor = UIColor.systemGray5.cgColor
        smallMenuToChangeView.layer.cornerRadius = 20
        smallMenuToChangeView.alpha = 0
        smallMenuToChangeView.transform = CGAffineTransform(translationX: 20, y: 0)
        
        addTypeNewsButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        addTypeNewsButton.contentVerticalAlignment = .fill
        addTypeNewsButton.contentHorizontalAlignment = .fill
        addTypeNewsButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addTypeNewsButton.isEnabled = false
        addTypeNewsButton.imageView?.tintColor = .systemGray5
        
        cancelChangesButton.setImage(UIImage(systemName: "clock.arrow.circlepath"), for: .normal)
        cancelChangesButton.contentVerticalAlignment = .fill
        cancelChangesButton.contentHorizontalAlignment = .fill
        cancelChangesButton.isEnabled = false
        cancelChangesButton.imageView?.tintColor = .systemGray5
        
        changeLanguageButton.setImage(UIImage(systemName: "globe"), for: .normal)
        changeLanguageButton.contentVerticalAlignment = .fill
        changeLanguageButton.contentHorizontalAlignment = .fill
        changeLanguageButton.imageView?.tintColor = .systemGray
        
        addTypeView.backgroundColor = .systemBackground
        addTypeView.layer.cornerRadius = 20
        
        addTypeLabel.text = "Add your category"
        addTypeLabel.textAlignment = .center
        
        addTypeTextField.backgroundColor = .systemGray5
        addTypeTextField.layer.cornerRadius = 5
        addTypeTextField.textAlignment = .center
        addTypeTextField.placeholder = "Input search keyword"
        addTypeTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
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
        tapToChangeButton.translatesAutoresizingMaskIntoConstraints = false
        tapToChangeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tapToChangeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        tapToChangeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        tapToChangeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        smallMenuToChangeView.translatesAutoresizingMaskIntoConstraints = false
        smallMenuToChangeView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        smallMenuToChangeView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        smallMenuToChangeView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        smallMenuToChangeView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90).isActive = true
        
        addTypeNewsButton.translatesAutoresizingMaskIntoConstraints = false
        addTypeNewsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addTypeNewsButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        addTypeNewsButton.bottomAnchor.constraint(equalTo: smallMenuToChangeView.bottomAnchor, constant: -5).isActive = true
        addTypeNewsButton.leftAnchor.constraint(equalTo: smallMenuToChangeView.leftAnchor, constant: 10).isActive = true
        
        cancelChangesButton.translatesAutoresizingMaskIntoConstraints = false
        cancelChangesButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cancelChangesButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        cancelChangesButton.bottomAnchor.constraint(equalTo: smallMenuToChangeView.bottomAnchor, constant: -5).isActive = true
        cancelChangesButton.leftAnchor.constraint(equalTo: addTypeNewsButton.rightAnchor, constant: 10).isActive = true
        cancelChangesButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        changeLanguageButton.translatesAutoresizingMaskIntoConstraints = false
        changeLanguageButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        changeLanguageButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        changeLanguageButton.bottomAnchor.constraint(equalTo: smallMenuToChangeView.bottomAnchor, constant: -5).isActive = true
        changeLanguageButton.leftAnchor.constraint(equalTo: cancelChangesButton.rightAnchor, constant: 10).isActive = true
        
    }
    
    func ConstrainTransparendViewIsVisible() {
        
        addTypeView.translatesAutoresizingMaskIntoConstraints = false
        addTypeView.heightAnchor.constraint(equalToConstant: 360).isActive = true
        addTypeView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        addTypeView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        addTypeView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        addTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        addTypeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addTypeLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
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
        if arrayWithTypes.count == 11 {
            addTypeNewsButton.isEnabled = false
            addTypeNewsButton.imageView?.tintColor = .systemFill
            cancelChangesButton.isEnabled = false
            cancelChangesButton.imageView?.tintColor = .systemFill
        } else {
            addTypeNewsButton.isEnabled = true
            addTypeNewsButton.imageView?.tintColor = .systemGreen
            cancelChangesButton.isEnabled = true
            cancelChangesButton.imageView?.tintColor = .systemBlue
        }
    }
    
    //MARK: - Transperend View
    
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
    
    //MARK: - @objc functions
    
    @objc func systemButtonTapped() {
        self.smallMenuToChangeView.alpha == 0 ?
        UIView.transition(with: smallMenuToChangeView, duration: 0.3) {
            self.smallMenuToChangeView.alpha = 1
            self.smallMenuToChangeView.transform = CGAffineTransform(translationX: 0, y: 0)
        } : UIView.transition(with: smallMenuToChangeView, duration: 0.3) {
            self.smallMenuToChangeView.alpha = 0
            self.smallMenuToChangeView.transform = CGAffineTransform(translationX: 20, y: 0)
        }
    }
    
    @objc func addButtonTapped() {
        addTransparentView()
    }
    
    @objc func cancelButtonTapped() {
        arrayWithTypes.removeAll()
        arrayWithTypes = NewsType.allCases.map({ type in
            return TypeFor.init(typeName: type.rawValue, typeImage: type.systemName)
        })
        typeTableView.reloadData()
        changeColorAndActivityOfButton()
    }
    
    @objc func textDidChange() {
        guard let text = addTypeTextField.text,
              selectedImage != nil else { return }
        okButton.backgroundColor = text.count > 2 ? .green : .systemGray3
        okButton.isEnabled = text.count > 2 ? true : false
    }
    
    @objc func addNewType() {
        if let text = addTypeTextField.text,
           text != "",
           let index = selectedIndexPath,
           let image = selectedImage {
            let typeStruct = TypeFor(typeName: text, typeImage: image)
            arrayWithTypes.append(typeStruct)
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
            self.typeTableView.deleteRows(at: [indexPath], with: .automatic)
            self.changeColorAndActivityOfButton()
        }
        return [deleteAction]
    }
    
    //MARK: - Collerction View Delegate and DataSource
    
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

