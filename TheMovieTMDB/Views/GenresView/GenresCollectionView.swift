//
//  GenresCollectionView.swift
//  TheMovieTMDB
//
//  Created by Aleksey Kuhlenkov on 3.03.24.
//

import UIKit

final class GenresCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "GenresCell")

        if let layout = layout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumLineSpacing = 20
            layout.scrollDirection = .vertical
            let cellWidth = UIScreen.main.bounds.width
            layout.itemSize = CGSize(width: cellWidth - 20, height: 50)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
