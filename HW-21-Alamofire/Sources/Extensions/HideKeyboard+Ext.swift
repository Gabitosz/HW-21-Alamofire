//
//  HideKeyboard+Ext.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 17.12.2023.
//

import UIKit

extension CharactersViewController: UIGestureRecognizerDelegate {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
        searchController.searchBar.resignFirstResponder()
    }
}
