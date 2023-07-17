//
//  MovieCell.swift
//  MoviesApp
//
//  Created by Жансая Шакуали on 16.07.2023.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let reuseID = "MovieCell"
    
    let movieImage = MovieImageView(frame: .zero)
    let titleLabel = MovieTitleLabel(textAlignment: .left, fontSize: 10)
    let descriptionLabel = DescriptionLabel(textAlignment: .left)
    
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMovieImage()
        configureDescriptionLabel()
        configureTitileLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: Movie) {
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
    }
    
    private func configureMovieImage() {
        contentView.addSubview(movieImage)
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieImage.heightAnchor.constraint(equalTo: movieImage.widthAnchor),
        ])
    }
    
    private func configureDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    private func configureTitileLabel() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -12)
        ])
    }
}
