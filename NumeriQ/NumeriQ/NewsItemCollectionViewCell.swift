//
//  NewsItemCollectionViewCell.swift
//  NumeriQ
//
//  Created by Ghislain Leblanc on 2020-09-03.
//  Copyright © 2020 Leblanc, Ghislain. All rights reserved.
//

import UIKit

protocol NewsItemCollectionViewCellViewModelProtocol {
    var title: String? { get }
    var source: String? { get }
    var description: String? { get }
    var imageUrl: String? { get }
}

class NewsItemCollectionViewCellViewModel: NewsItemCollectionViewCellViewModelProtocol {
    let title: String?
    let source: String?
    let description: String?
    let imageUrl: String?

    init(title: String?, source: String?, description: String?, imageUrl: String?) {
        self.title = title
        self.source = source
        self.description = description
        self.imageUrl = imageUrl
    }
}

protocol NewsItemCollectionViewCellProtocol {
    var viewModel: NewsItemCollectionViewCellViewModelProtocol? { get set }
    func setup()
}

class NewsItemCollectionViewCell: UICollectionViewCell, NewsItemCollectionViewCellProtocol {
    static let reuseIdentifier = "Cell"

    var viewModel: NewsItemCollectionViewCellViewModelProtocol?

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var desciptionLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setup() {
        titleLabel.text = viewModel?.title
        sourceLabel.text = viewModel?.source
        desciptionLabel.text = viewModel?.description

        if let url = URL(string: viewModel?.imageUrl ?? "") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async { [weak self] in
                            self?.imageView.image = image
                        }
                    }
                }
            }
        }
    }
}
