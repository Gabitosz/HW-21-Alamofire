//
//  ModalViewController.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 17.12.2023.
//

import UIKit

class ModalViewController: UIViewController {
    
    // MARK: Outlets
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.blue.cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var eventsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var comicsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: Setup
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupHierarchy() {
        let views = [characterImageView, titleLabel, descriptionLabel, eventsLabel, comicsLabel]
        views.forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 350),
            
            characterImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            characterImageView.widthAnchor.constraint(equalToConstant: 60),
            characterImageView.heightAnchor.constraint(equalToConstant: 60),
            
            descriptionLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 50),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            eventsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            eventsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            eventsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            comicsLabel.topAnchor.constraint(equalTo: eventsLabel.bottomAnchor, constant: 30),
            comicsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            comicsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
        ])
    }
    
    func configure(with selectedHero: Character) {
    
        AlamofireManager.fetchImage(for: selectedHero) { image in
                   DispatchQueue.main.async {
                       self.characterImageView.image = image
                       self.characterImageView.layer.cornerRadius = self.characterImageView.frame.size.width / 2
                   }
               }
        
        titleLabel.text = "Hero name: \n\n \(selectedHero.name)"
        
        descriptionLabel.text = "Description: \n\n \(selectedHero.description == "" ? "Not specified" : "\(selectedHero.description)")"
        
        if selectedHero.events.items.isEmpty {
            eventsLabel.text = "Events: \n\n There have been no events with this character"
        }
        else {
            let firstTenEvents = selectedHero.events.items.prefix(10)
            let events = firstTenEvents.map { $0.name }
            eventsLabel.text = "Events: \n\n \(events.joined(separator: ", "))"
        }
        
        if selectedHero.comics.items.isEmpty {
            comicsLabel.text = "Comics: \n\n There have been no comics with this character"
        }
        else {
            let firstTenComics = selectedHero.comics.items.prefix(10)
            let comics = firstTenComics.map { $0.name }
            comicsLabel.text = "Comics: \n\n \(comics.joined(separator: "\n"))"
        }
    }
    
}
