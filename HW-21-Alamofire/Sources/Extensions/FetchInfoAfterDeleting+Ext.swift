//
//  FetchInfoAfterDeleting+Ext.swift
//  HW-21-Alamofire
//
//  Created by Gabriel Zdravkovici on 17.12.2023.
//

import UIKit

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty {
            fetchCharactersInfo()
        }
        
        return true
    }
}
