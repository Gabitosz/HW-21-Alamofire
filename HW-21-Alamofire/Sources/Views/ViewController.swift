//
//  ViewController.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 11.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTableConstraints()
        setupNavigationBar()
        fetchInfo()
    }
    
    // MARK: Setup
    
    func setupTableConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterCell")
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Marvel Heroes"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func fetchInfo() {
        AlamofireManager.fetchCharacters(countOfCharacters: 20) {
            self.tableView.reloadData()
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
            let firstFiftheenEvents = selectedHero.events.items.prefix(10)
            let events = firstFiftheenEvents.map { $0.name }
            modalView.eventsLabel.text = "Events: \n\n \(events.joined(separator: ", "))"
        }
        
        if selectedHero.comics.items.isEmpty {
            modalView.comicsLabel.text = "Comics: \n\n There have been no comics with this character"
        }
        else {
            let firstFiftheenComics = selectedHero.comics.items.prefix(10)
            let comics = firstFiftheenComics.map { $0.name }
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

