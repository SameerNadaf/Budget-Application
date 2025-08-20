//
//  VerticalStackView.swift
//  BudgetApp
//
//  Created by Sameer  on 20/08/25.
//

import UIKit

class VerticalStackView: UIStackView {
    init(margins: NSDirectionalEdgeInsets) {
        super.init(frame: .zero)
        
        self.axis = .vertical
        self.spacing = UIStackView.spacingUseSystem
        self.isLayoutMarginsRelativeArrangement = true
        self.directionalLayoutMargins = margins
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
