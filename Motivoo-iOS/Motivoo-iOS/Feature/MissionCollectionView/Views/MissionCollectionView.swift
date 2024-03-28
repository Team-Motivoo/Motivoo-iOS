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
    let todayMissionHeader = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }


    // MARK: - Override Functions

    override func setHierachy() {
        addSubview(todayMissionHeader)
    }

    override func setUI() {
        todayMissionHeader.do {
            $0.register(CollectionHeaderCell.self,
                        forCellWithReuseIdentifier: CollectionHeaderCell.identifier)
        }
    }

    override func setLayout() {
        todayMissionHeader.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(415.adjusted)
        }
    }
}
