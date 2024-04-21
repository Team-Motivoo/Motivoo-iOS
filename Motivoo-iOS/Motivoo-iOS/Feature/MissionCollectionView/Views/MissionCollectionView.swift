//
//  MissionCollectionView.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 3/28/24.
//

import UIKit

import SnapKit
import Then

final class MissionCollectionView: BaseView {

    // MARK: - UI Components
    let missionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }


    // MARK: - Override Functions

    override func setHierachy() {
        addSubview(missionCollectionView)
    }

    override func setUI() {
        missionCollectionView.do {
            $0.register(CollectionHeaderCell.self,
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderCell.identifier)
            $0.register(CollectionViewCell.self,
                        forCellWithReuseIdentifier: CollectionViewCell.identifier)
            $0.showsVerticalScrollIndicator = false
        }
    }

    override func setLayout() {
        missionCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
