//
//  NewsFeed.swift
//  NumeriQ
//
//  Created by Ghislain Leblanc on 2020-09-03.
//  Copyright © 2020 Leblanc, Ghislain. All rights reserved.
//

import Foundation

struct NewsFeed: Decodable {
    var articles: [NewsItem]

    enum CodingKeys: String, CodingKey {
        case articles
    }
}
