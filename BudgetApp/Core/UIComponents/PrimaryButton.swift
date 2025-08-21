//
//  PrimaryButton.swift
//  BudgetApp
//
//  Created by Sameer  on 20/08/25.
//

import UIKit

class PrimaryButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .large
        config.title = title
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        self.configuration = config
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
