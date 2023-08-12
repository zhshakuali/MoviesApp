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
    let titleLabel = MovieTitleLabel(textAlignment: .left, fontSize: 12)
    let descriptionLabel = DescriptionLabel(textAlignment: .left)
    
    let padding: CGFloat = 8
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: Movie) {
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        movieImage.downloadImage(from: movie.posterPath)
    }
    
    private func configureStackView() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(movieImage)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor),
            
            movieImage.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
