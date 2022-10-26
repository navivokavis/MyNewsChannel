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

enum NewsType: String, CaseIterable {
    case ukraine = "Ukraine"
    case war = "War"
    case business = "Business"
    case entertainment = "Entertainment"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case architecture = "Architecture"
    case fashion = "Fashion"
    case technology = "Technology"
    case covid = "Covid-19"
    
    var systemName: String {
        switch self {
        case .ukraine:
            return "bolt.fill"
        case .war:
            return "multiply.square.fill"
        case .business:
            return "briefcase"
        case .entertainment:
            return "film"
        case .health:
            return "stethoscope"
        case .science:
            return "function"
        case .sports:
            return "sportscourt"
        case .architecture:
            return "building.2"
        case .technology:
            return "gear"
        case .fashion:
            return "crown"
        case .covid:
            return "stethoscope"
        }
    }
}
