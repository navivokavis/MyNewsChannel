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

//enum Pictures: String, CaseIterable {
//    case one
//    case speaker
//    case ellipsis
//    case chart
//    case bubble
//    case video
//    case sun
//    case cross
//    case trash
//    case paperplane
//    case books
//    case gamecontroller
//    case car
//    case exclamationmark
//    case heart
//    case plus
//    case highlighter
//    case scissors
//    case globe
//    case trophy
//    case flag
//    case frying
//    case hand
//    case cart
//    case infinity
//    case dollarsign
//    case bitcoinsign
//    case alarm
//    case arrowshape
//    case info
//
//    var image: UIImage {
//            switch self {
//            case .one: return UIImage(systemName: "rays")!
//                case .speaker:
//                return UIImage(systemName: "speaker.wave.2.fill")!
//                case .ellipsis:
//                return UIImage(systemName: "ellipsis.bubble.fill")!
//                case .chart:
//                return UIImage(systemName: "chart.bar.fill")!
//            case .bubble:
//                return UIImage(systemName: "bubble.left.and.bubble.right.fill")!
//            case .video:
//                return UIImage(systemName: "video.fill")!
//            case .sun:
//                return UIImage(systemName: "sun.min.fill")!
//            case .cross:
//                return UIImage(systemName: "cross.fill")!
//            case .trash:
//                return UIImage(systemName: "trash")!
//            case .paperplane:
//                return UIImage(systemName: "paperplane.fill")!
//            case .books:
//                return UIImage(systemName: "books.vertical.fill")!
//            case .gamecontroller:
//                return UIImage(systemName: "gamecontroller.fill")!
//            case .car:
//                return UIImage(systemName: "car.fill")!
//            case .exclamationmark:
//                return UIImage(systemName: "exclamationmark.triangle.fill")!
//            case .heart:
//                return UIImage(systemName: "heart.fill")!
//            case .plus:
//                return UIImage(systemName: "plus")!
//            case .highlighter:
//                return UIImage(systemName: "highlighter")!
//            case .scissors:
//                return UIImage(systemName: "scissors")!
//            case .globe:
//                return UIImage(systemName: "globe.europe.africa.fill")!
//            case .trophy:
//                return UIImage(systemName: "trophy.fill")!
//            case .flag:
//                return UIImage(systemName: "flag.2.crossed.fill")!
//            case .frying:
//                return UIImage(systemName: "frying.pan.fill")!
//            case .hand:
//                return UIImage(systemName: "hand.wave.fill")!
//            case .cart:
//                return UIImage(systemName: "cart.fill")!
//            case .infinity:
//                return UIImage(systemName: "infinity")!
//            case .dollarsign:
//                return UIImage(systemName: "dollarsign.circle.fill")!
//            case .bitcoinsign:
//                return UIImage(systemName: "bitcoinsign.circle")!
//            case .alarm:
//                return UIImage(systemName: "alarm.waves.left.and.right.fill")!
//            case .arrowshape:
//                return UIImage(systemName: "arrowshape.backward.fill")!
//            case .info:
//                return UIImage(systemName: "info.square")!
//            }
//        }


enum Pictures: String, CaseIterable {
    case one
    case speaker
    case ellipsis
    case chart
    case bubble
    case video
    case sun
    case cross
    case trash
    case paperplane
    case books
    case gamecontroller
    case car
    case exclamationmark
    case heart
    case plus
    case highlighter
    case scissors
    case globe
    case trophy
    case flag
    case frying
    case hand
    case cart
    case infinity
    case dollarsign
    case bitcoinsign
    case alarm
    case arrowshape
    case info
    
    var image: String {
            switch self {
            case .one:
                return "rays"
                case .speaker:
                return "speaker.wave.2.fill"
                case .ellipsis:
                return "ellipsis.bubble.fill"
                case .chart:
                return "chart.bar.fill"
            case .bubble:
                return "bubble.left.and.bubble.right.fill"
            case .video:
                return "video.fill"
            case .sun:
                return "sun.min.fill"
            case .cross:
                return "cross.fill"
            case .trash:
                return "trash"
            case .paperplane:
                return "paperplane.fill"
            case .books:
                return "books.vertical.fill"
            case .gamecontroller:
                return "gamecontroller.fill"
            case .car:
                return "car.fill"
            case .exclamationmark:
                return "exclamationmark.triangle.fill"
            case .heart:
                return "heart.fill"
            case .plus:
                return "plus"
            case .highlighter:
                return "highlighter"
            case .scissors:
                return "scissors"
            case .globe:
                return "globe.europe.africa.fill"
            case .trophy:
                return "trophy.fill"
            case .flag:
                return "flag.2.crossed.fill"
            case .frying:
                return "frying.pan.fill"
            case .hand:
                return "hand.wave.fill"
            case .cart:
                return "cart.fill"
            case .infinity:
                return "infinity"
            case .dollarsign:
                return "dollarsign.circle.fill"
            case .bitcoinsign:
                return "bitcoinsign.circle"
            case .alarm:
                return "alarm.waves.left.and.right.fill"
            case .arrowshape:
                return "arrowshape.backward.fill"
            case .info:
                return "info.square"
            }
        }
}
