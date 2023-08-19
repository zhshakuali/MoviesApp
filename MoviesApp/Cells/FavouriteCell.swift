//
//  FavouriteCell.swift
//  MoviesApp
//
//  Created by Жансая Шакуали on 11.08.2023.
//

import UIKit

class FavouriteCell: UITableViewCell {

    static let reuseId = "FavouriteCell"
    
    let movieImage = MovieImageView(frame: .zero)
    let titleLabel = MovieTitleLabel(textAlignment: .left, fontSize: 20)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favourite: Movie) {
        movieImage.downloadImage(from: favourite.posterPath)
        titleLabel.text = favourite.title
    }
    
    private func configure() {
        addSubview(movieImage)
        addSubview(titleLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            movieImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            movieImage.heightAnchor.constraint(equalToConstant: 60),
            movieImage.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
