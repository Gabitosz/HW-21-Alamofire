//
//  CharacterTableViewCell.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 12.12.2023.
//

import UIKit
import Alamofire
import AlamofireImage

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
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.blue.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupViews() {
        let views = [nameLabel, comicsLabel, eventsLabel, characterImageView]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        views.forEach { contentView.addSubview($0) }
    }
    
    
    private func setupLayout() {
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
            eventsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            characterImageView.widthAnchor.constraint(equalToConstant: 60),
            characterImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configure(with character: Character) {
        nameLabel.text = "Hero Name: \(character.name)"
        comicsLabel.text = "Comics available: \(String(describing: character.comics.available))"
        eventsLabel.text = "Events available: \(String(describing: character.events.available))"
        
        AlamofireManager.fetchImage(for: character) { [weak self] image in
            if let image = image {
                self?.characterImageView.image = image
                self?.characterImageView.layer.cornerRadius = (self?.characterImageView.frame.size.width ?? 0) / 2
            }
        }
    }
}
