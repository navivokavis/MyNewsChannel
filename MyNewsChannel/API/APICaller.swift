//
//  APICaller.swift
//  MyNewsChannel
//
//  Created by Navi Vokavis on 18.10.22.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = APIProperty.shared.topHeadlinesURL else { return }
        
        let task = URLSession.shared.dataTask(with:  url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                 
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("this is result \(result)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))

                }
            }
        }
        task.resume()
    }
    public func searchStories(title: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: "\(APIProperty.shared.forSearchLink)\(title.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? "")\(APIProperty.shared.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with:  url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                 
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("this is result \(result)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))

                }
            }
        }
        task.resume()
    }
}




