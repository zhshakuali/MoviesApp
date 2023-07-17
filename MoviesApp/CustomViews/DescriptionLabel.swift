//
//  DescriptionLabel.swift
//  MoviesApp
//
//  Created by Жансая Шакуали on 16.07.2023.
//

import UIKit

class DescriptionLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        //        lineBreakMode = .byWordWrapping
        numberOfLines = 5
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
