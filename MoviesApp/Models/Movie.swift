//
//  Movie.swift
//  MoviesApp
//
//  Created by Жансая Шакуали on 16.07.2023.
//

import UIKit
struct Model: Codable {
    var results: [Movie]
}

struct Movie: Hashable, Codable {
    var title: String
    var overview: String
    var posterPath: String
}
