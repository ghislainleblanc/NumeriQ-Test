//
//  ViewController.swift
//  NumeriQ
//
//  Created by Ghislain Leblanc on 2020-09-03.
//  Copyright © 2020 Leblanc, Ghislain. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!

    private var newsFeedItems: BehaviorRelay<[NewsItem]> = BehaviorRelay(value: [])

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NetworkManager.shared.getNewsFeed { [weak self] (newsFeed) in
            self?.newsFeedItems.accept(newsFeed.articles)
        }

        newsFeedItems.asObservable().bind(to: collectionView.rx.items(cellIdentifier: NewsItemCollectionViewCell.reuseIdentifier, cellType: NewsItemCollectionViewCell.self)) { indexPath, item, cell in
            cell.titleLabel.text = item.title
            cell.desciptionLabel.text = item.description
            cell.sourceLabel.text = item.source?.name

            if let url = URL(string: item.urlToImage ?? "") {
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
        }.disposed(by: disposeBag)
    }
}
