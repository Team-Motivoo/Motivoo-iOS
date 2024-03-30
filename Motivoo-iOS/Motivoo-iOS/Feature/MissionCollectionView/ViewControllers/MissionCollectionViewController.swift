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
        missionCollectionView.missionCollectionView.dataSource = self
        missionCollectionView.missionCollectionView.delegate = self
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
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Actions
}

extension MissionCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderCell.identifier, for: indexPath) as? CollectionHeaderCell else {
                return CollectionHeaderCell()
            }
            return header
        } else {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderCell.identifier, for: indexPath) as? CollectionHeaderCell else {
                return CollectionHeaderCell()
            }
            return header
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 376.adjusted)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension MissionCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 308.adjusted)
    }
}
