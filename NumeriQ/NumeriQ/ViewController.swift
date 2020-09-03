//
//  ViewController.swift
//  NumeriQ
//
//  Created by Ghislain Leblanc on 2020-09-03.
//  Copyright © 2020 Leblanc, Ghislain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        NetworkManager.shared.getNewsFeed { (newsFeed) in
            print(newsFeed?.articles.count)
        }
    }
}

