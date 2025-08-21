//
//  StackView.swift
//  BudgetApp
//
//  Created by Sameer  on 21/08/25.
//

import UIKit

class StackView: UIStackView {
    init(axis: NSLayoutConstraint.Axis = .vertical ,margins: NSDirectionalEdgeInsets) {
        super.init(frame: .zero)
        self.axis = axis
        self.spacing = UIStackView.spacingUseSystem
        self.isLayoutMarginsRelativeArrangement = true
        self.directionalLayoutMargins = margins
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
