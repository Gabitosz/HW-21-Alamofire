//
//  SearchResults+Ext.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 24.12.2023.
//

import UIKit

extension CharactersViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        self.filteredHeroes = AlamofireManager.characters.filter({ (character: Character) in
            return character.name.lowercased().contains(searchText.lowercased())
        })
        self.tableView.reloadData()
    }
}
