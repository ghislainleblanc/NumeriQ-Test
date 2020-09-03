//
//  ViewController.swift
//  NumeriQ
//
//  Created by Ghislain Leblanc on 2020-09-03.
//  Copyright © 2020 Leblanc, Ghislain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    var newsFeedItems: [NewsItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkManager.shared.getNewsFeed { [weak self] (newsFeed) in
            print(newsFeed?.articles.count)
            self?.newsFeedItems = newsFeed?.articles
            self?.collectionView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsFeedItems?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsItemCollectionViewCell.reuseIdentifier, for: indexPath) as! NewsItemCollectionViewCell
        cell.titleLabel.text = newsFeedItems?[indexPath.row].title
        cell.desciptionLabel.text = newsFeedItems?[indexPath.row].description
        cell.sourceLabel.text = newsFeedItems?[indexPath.row].source?.name

        if let url = URL(string: newsFeedItems?[indexPath.row].urlToImage ?? "") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.imageView.image = image
                        }
                    }
                }
            }
        }

        return cell
    }
}
