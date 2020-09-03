//
//  NetworkManager.swift
//  NumeriQ
//
//  Created by Ghislain Leblanc on 2020-09-03.
//  Copyright © 2020 Leblanc, Ghislain. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()

    private let apiEndPoint = "https://newsapi.org/v2/everything"
    private let apiKey = "5b025c1696634ffeb4e1704dfc68f551"

    func getNewsFeed(completion: @escaping (NewsFeed) -> Void) {
        let URL = "\(apiEndPoint)?q=bitcoin&from=2020-08-03&sortBy=publishedAt&apiKey=\(apiKey)"

        AF.request(URL)
            .validate()
            .responseDecodable(of: NewsFeed.self) { (response) in
                guard let feed = response.value else { return }
                completion(feed)
        }
    }
}
