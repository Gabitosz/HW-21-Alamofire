//
//  ViewController.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 11.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var isKeyboardOpen = false
    
    // MARK: Outlets
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter the hero's name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.textAlignment = .center
        textField.layer.masksToBounds = true
        textField.keyboardType = .asciiCapable
        textField.delegate = self
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(fetchInfoAboutHero), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupViews()
        setupTableViewCell()
        setupConstraints()
        setupNavigationBar()
        fetchCharactersInfo()
        hideKeyboard()
    }
    
    // MARK: Setup
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            searchButton.widthAnchor.constraint(equalToConstant: 120),
            searchButton.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
    
    func configureView() {
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = .systemBackground
    }
    
    func setupTableViewCell() {
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterCell")
    }
    
    func setupViews() {
        let views = [tableView, textField, searchButton]
        views.forEach { view.addSubview($0) }
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Marvel Heroes"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset > 0 || offset < -50 {
            // Прокрутка вниз
            textField.isHidden = true
            searchButton.isHidden = true
            
        } else if offset == 0  {
            // Прокрутка вверх
            textField.isHidden = false
            searchButton.isHidden = false
        }
    }
    
    func fetchCharactersInfo() {
        AlamofireManager.fetchInfoAbout(countOfCharacters: 20) {
            self.tableView.reloadData()
        }
    }
    
    @objc func fetchInfoAboutHero() {
        
        if let heroName = textField.text {
            AlamofireManager.fetchCharacterBy(name: heroName) {
                if AlamofireManager.characters.isEmpty {
                    let alertController = UIAlertController(title: "Warning", message: "Hero with name \(heroName) doesn't exist", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    
                    self.present(alertController, animated: true)
                    self.fetchCharactersInfo()
                }
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: ViewController Extensions

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedHero = AlamofireManager.characters[indexPath.row]
        let modalView = ModalViewController()
        
        modalView.titleLabel.text = "Hero name: \n\n \(selectedHero.name)"
        modalView.descriptionLabel.text = "Description: \n\n \(selectedHero.description == "" ? "Not specified" : "\(selectedHero.description)")"
        
        if selectedHero.events.items.isEmpty {
            modalView.eventsLabel.text = "Events: \n\n There have been no events with this character"
        }
        else {
            let firstTenEvents = selectedHero.events.items.prefix(10)
            let events = firstTenEvents.map { $0.name }
            modalView.eventsLabel.text = "Events: \n\n \(events.joined(separator: ", "))"
        }
        
        if selectedHero.comics.items.isEmpty {
            modalView.comicsLabel.text = "Comics: \n\n There have been no comics with this character"
        }
        else {
            let firstTenComics = selectedHero.comics.items.prefix(10)
            let comics = firstTenComics.map { $0.name }
            modalView.comicsLabel.text = "Comics: \n\n \(comics.joined(separator: "\n"))"
        }
        present(modalView, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AlamofireManager.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterTableViewCell
        let character = AlamofireManager.characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
}

// MARK: Disable table view cells when keyboard is active

extension ViewController {
    
    func hideKeyboard() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        isKeyboardOpen = true
        tableView.isUserInteractionEnabled = false
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        isKeyboardOpen = false
        tableView.isUserInteractionEnabled = true
    }
}


