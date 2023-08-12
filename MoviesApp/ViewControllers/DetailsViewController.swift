//
//  DetailsViewController.swift
//  MoviesApp
//
//  Created by Жансая Шакуали on 23.07.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let selectedMovie: Movie
    var starImage = UIImage(named: "custom.star")
    var isFavourite = false
    
    let movieImage = MovieImageView(frame: .zero)
    let titleLabel = MovieTitleLabel(textAlignment: .left, fontSize: 20)
    let descriptionLabel = DescriptionLabel(textAlignment: .left)
    
    init(selectedMovie: Movie) {
        self.selectedMovie = selectedMovie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setContent()
        configureFavouriteButton()
        checkFilm()
    }
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    func checkFilm() {
        PersistenceManager.retrieveFavourites { result in
            switch result {
            case .success(let success):
                self.isFavourite = success.contains(where: {
                    $0.title == self.selectedMovie.title
                })
                self.setImageForButton(isFavourite: self.isFavourite)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func setLayout() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
        
        mainStackView.addArrangedSubview(movieImage)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            movieImage.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            movieImage.heightAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 12 / 16)
        ])
    }
    
    func setContent() {
        movieImage.downloadImage(from: selectedMovie.posterPath)
        titleLabel.text = selectedMovie.title
        descriptionLabel.text = selectedMovie.overview
    }
    
    func configureFavouriteButton() {
        let favouriteButtonStar = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(favouriteButton))
        navigationItem.rightBarButtonItem = favouriteButtonStar
    }
    
    
    @objc func favouriteButton() {
        let actionType: PersistanceActiontype = isFavourite ? .remove : .add

          PersistenceManager.updateWith(favourite: selectedMovie, actionType: actionType) { [weak self] error in
              guard let self = self, error == nil else { return }

              self.isFavourite.toggle()
              self.setImageForButton(isFavourite: self.isFavourite)
              print(self.selectedMovie)
          }
    }
    
    func setImageForButton(isFavourite: Bool) {
        navigationItem.rightBarButtonItem?.image = isFavourite
        ? UIImage(systemName: "star.fill")
        : UIImage(systemName: "star")
    }
}
