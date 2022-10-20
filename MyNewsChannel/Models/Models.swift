//
//  NewsTableViewCellViewModel.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 18.10.22.
//

import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    var published: String
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?,
        published: String
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.published = published
    }
}

//class TopNewsTableViewCellViewModel {
//    let title: String
//    let subtitle: String
//    let imageURL: URL?
//    var imageData: Data? = nil
//    var published: String
//
//    init(
//        title: String,
//        subtitle: String,
//        imageURL: URL?,
//        published: String
//    ) {
//        self.title = title
//        self.subtitle = subtitle
//        self.imageURL = imageURL
//        self.published = published
//    }
//}
//struct Constans {
//    static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=7e19dda7c07f4af18ada19f113022fcd")
//    
//}

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    
}
