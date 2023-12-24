//
//  ViewController.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 11.12.2023.
//

import UIKit

class CharactersViewController: UIViewController {
    
    var filteredHeroes = [Character]()
    
    // MARK: Outlets
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterCell")
        return tableView
        
    }()
    
    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search"
        controller.searchBar.keyboardType = .asciiCapable
        definesPresentationContext = true
        
        return controller
    }()
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupHierarchy()
        setupLayout()
        setupNavigationBar()
        fetchCharactersInfo()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: Setup
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Marvel Heroes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset > 0 || offset < -50 {
            // Прокрутка вниз
        } else if offset == 0  {
            // Прокрутка вверх
        }
    }
    
    func fetchCharactersInfo() {
        AlamofireManager.fetchInfoAbout(countOfCharacters: 20) {
            self.tableView.reloadData()
        }
    }
    
    @objc func fetchInfoAboutHero() {
        
        if let heroName = searchController.searchBar.text {
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

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var selectedHero: Character
        
        if isFiltering {
            selectedHero = filteredHeroes[indexPath.row]
        } else {
            selectedHero = AlamofireManager.characters[indexPath.row]
        }
        
        let modalView = ModalViewController()
        
        modalView.configure(with: selectedHero)
        present(modalView, animated: true)
    }
}

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredHeroes.count
        }
        return AlamofireManager.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterTableViewCell
        var character: Character
        
        if isFiltering {
            character = filteredHeroes[indexPath.row]
        } else {
            character = AlamofireManager.characters[indexPath.row]
        }
        
        cell.configure(with: character)
        return cell
    }
    
}

