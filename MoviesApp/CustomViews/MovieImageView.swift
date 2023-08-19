//
//  MovieImageView.swift
//  MoviesApp
//
//  Created by Жансая Шакуали on 16.07.2023.
//

import UIKit


class MovieImageView: UIImageView {
    
    let cache = NSCache<NSString, UIImage>()
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
        contentMode = .scaleAspectFill
    }
    
    func downloadImage(from posterPath: String) {
        
        let basicImageUrl = "https://image.tmdb.org/t/p/original"
        let cacheKey = NSString(string: basicImageUrl + posterPath)

        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            
            return
        }
        
        guard let url = URL(string: basicImageUrl + posterPath) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200
            else {
                return
            }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async { self.image = image }
        }.resume()
    }
}
