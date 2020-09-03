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
import Swinject

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
            let container = Container()
            container.register(NewsItemCollectionViewCellViewModel.self) { _ in
                NewsItemCollectionViewCellViewModel(title: item.title, source: item.source?.name, description: item.description, imageUrl: item.urlToImage)
            }
            cell.viewModel = container.resolve(NewsItemCollectionViewCellViewModel.self)!
            cell.setup()
        }.disposed(by: disposeBag)
    }
}
