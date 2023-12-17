//
//  ViewController.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 11.12.2023.
//

import UIKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTableConstraints()
        setupNavigationBar()
        fetchInfo()
    }

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

