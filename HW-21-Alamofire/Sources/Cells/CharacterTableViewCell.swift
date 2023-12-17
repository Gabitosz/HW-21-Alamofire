//
//  CharacterTableViewCell.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 12.12.2023.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    
    let comicsLabel: UILabel = {
        let comicsLabel = UILabel()
        return comicsLabel
    }()
    
    let eventsLabel: UILabel = {
        let eventsLabel = UILabel()
        return eventsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupViews() {
        let views = [nameLabel, comicsLabel, eventsLabel]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        views.forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            comicsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            comicsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            comicsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            eventsLabel.topAnchor.constraint(equalTo: comicsLabel.bottomAnchor, constant: 8),
            eventsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            eventsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            eventsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with character: Character) {
        nameLabel.text = "Hero Name: \(character.name)"
        comicsLabel.text = "Comics available: \(String(describing: character.comics.available))"
        eventsLabel.text = "Events available: \(String(describing: character.events.available))"
    }
}
