//
//  FocusViewController+Extension.swift
//  Windows
//
//  Created by xcv on 12/02/2021.
//

import Foundation
import UIKit

extension FocusViewController {
    
    // MARK: Setup darkmode
    func setupDarkNavBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.yellow]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .black
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupDarkNavBar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
