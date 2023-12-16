//
//  ViewController.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 11.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var characters = [Character]()
    
    let firstChar = Character(id: 1, name: "First", description: "Descr", comics: Comics(available: 1, items: [Comic(name: "Comic")]), events: Events(available: 1, items: [Event(name: "Event")]))
    
    let secondChar = Character(id: 1, name: "First", description: "Descr", comics: Comics(available: 1, items: [Comic(name: "Comic")]), events: Events(available: 1, items: [Event(name: "Event")]))
    
    func add() {
        characters.append(firstChar)
        characters.append(secondChar)
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        add()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterCell")
        setupTableConstraints()
    }
    
    func setupTableConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterTableViewCell
        let character = characters[indexPath.row]
        
        cell.configure(with: character)
        return cell
    }
    
    
}

