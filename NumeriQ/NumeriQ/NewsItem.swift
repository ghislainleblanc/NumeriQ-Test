//
//  NewsItem.swift
//  NumeriQ
//
//  Created by Ghislain Leblanc on 2020-09-03.
//  Copyright © 2020 Leblanc, Ghislain. All rights reserved.
//

import Foundation

struct NewsItem: Decodable {
    var title: String?
    var description: String?
    var urlToImage: String?
    var source: Source?
}
