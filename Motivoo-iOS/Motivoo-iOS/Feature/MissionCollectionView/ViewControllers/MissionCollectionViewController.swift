//
//  MissionCollectionViewController.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 3/25/24.
//

import UIKit

import SnapKit
import Then

final class MissionCollectionViewController: BaseViewController {

    //MARK: - Properties

    // MARK: - UI Component
    lazy var missionCollectionView = MissionCollectionView()

    private func setCollectionViewConfig() {
        missionCollectionView.todayMissionHeader.dataSource = self
    }

    // MARK: - Override Functions

    override func viewWillAppear(_ animated: Bool) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setCollectionViewConfig()
    }

    override func setHierachy() {
        self.view.addSubviews(missionCollectionView)
    }

    override func setLayout() {
        missionCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    // MARK: - Actions
}

extension MissionCollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == missionCollectionView.todayMissionHeader {
            print("=== collectionView: todayMissionHeader")
            return 1
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == missionCollectionView.todayMissionHeader {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionHeaderCell.identifier, for: indexPath) as! CollectionHeaderCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionHeaderCell.identifier, for: indexPath) as! CollectionHeaderCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == missionCollectionView.todayMissionHeader {
            return CGSize(width: UIScreen.main.bounds.size.width, height: 415)
        }
        return CGSize(width: 0, height: 0)
    }
}
