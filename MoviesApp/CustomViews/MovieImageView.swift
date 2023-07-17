//
//  MovieImageView.swift
//  MoviesApp
//
//  Created by Жансая Шакуали on 16.07.2023.
//

import UIKit

class MovieImageView: UIImageView {
    
    let movieImage = UIImage(named: "image")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = movieImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
