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
    var missionHistory: OverViewResponse? {
        didSet {
            missionCollectionView.missionCollectionView.reloadData()
            historyCount = missionHistory?.missionHistory.count ?? 0
            print("=== change missionHistoryData")
        }
    }

    lazy var historyCount = missionHistory?.missionHistory.count ?? 0

    // MARK: - UI Component
    lazy var missionCollectionView = MissionCollectionView()
    private let missionEmptyView = MissionEmptyView()
    private let emptyImageView = UIImageView()

    private func setCollectionViewConfig() {
        missionCollectionView.missionCollectionView.dataSource = self
        missionCollectionView.missionCollectionView.delegate = self
    }

    // MARK: - Override Functions

    override func viewWillAppear(_ animated: Bool) {
        requestOverviewAPI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.missionEmptyView.isHidden = true
        self.emptyImageView.isHidden = true
        setCollectionViewConfig()
        requestOverviewAPI()
    }

    override func setHierachy() {
        self.view.addSubviews(missionCollectionView, missionEmptyView, emptyImageView)
    }

    override func setLayout() {
        missionCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        missionEmptyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        emptyImageView.do {
            $0.image = ImageLiterals.img.notexerciseGray
        }
        emptyImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(440.adjusted)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(120.adjusted)
        }
    }

    // MARK: - Actions
}

extension MissionCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = missionHistory?.missionHistory.count ?? 0
        count -= 1
        if count == 0 {
            self.emptyImageView.isHidden = false
        } else {
            self.emptyImageView.isHidden = true

        }
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell

        let date = missionHistory?.missionHistory[indexPath.row]?.date ?? ""
        let myImage = missionHistory?.missionHistory[indexPath.row]?.myMissionImgURL ?? nil
        let myMission = missionHistory?.missionHistory[indexPath.row]?.myMissionContent ?? ""
        let myStatus = missionHistory?.missionHistory[indexPath.row]?.myMissionStatus ?? ""
        let partnerImage = missionHistory?.missionHistory[indexPath.row]?.opponentMissionImgURL ?? nil
        let partnerMission = missionHistory?.missionHistory[indexPath.row]?.opponentMissionContent ?? ""
        let partnerStatusChip = missionHistory?.missionHistory[indexPath.row]?.opponentMissionStatus ?? ""

        cell.setMissionHistory(date: date,
                               myImage: myImage, myMission: myMission, mySuccess: myStatus,
                               partnerImage: partnerImage, partnerMission: partnerMission, partnerSuccess: partnerStatusChip)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderCell.identifier, for: indexPath) as? CollectionHeaderCell else {
                return CollectionHeaderCell()
            }

            if missionHistory?.userType == "부모" {
                header.changeIcon()
            }
            if missionHistory?.todayMission == nil {
                // today 미션 없으면 버튼 반환
                header.setNotTodayMission()
            } else {
                // today 미션 있으면
                header.setTodayMission(todatMission: missionHistory?.todayMission?.missionContent ?? "")
                let todayMission = missionHistory?.missionHistory[historyCount-1]
                header.setTodaySection(myMissionImage: todayMission?.myMissionImgURL, myStatus: todayMission?.myMissionStatus ?? "", partnerMissionImage: todayMission?.opponentMissionImgURL, partnerStatus: todayMission?.opponentMissionStatus ?? "")
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

extension MissionCollectionViewController {
    func requestOverviewAPI() {
        OverviewAPI.shared.getMission()  { result in
            guard let result = self.validateResult(result) as? OverViewResponse else {
                return
            }
            self.missionHistory = result
            self.missionEmptyView.isHidden = true

            if result.missionHistory.count == 1 ||  result.missionHistory.count == 0{
                if result.todayMission == nil {
                    // 히스트로 X, 미션 선택 X./
                    print("=== 히스트로 X, 미션 선택 X: \(result)")
                    self.missionCollectionView.isHidden = true
                    self.missionEmptyView.isHidden = false
                } else {
                    // 히스트로 X, 미션 선택 O
                    print("=== 히스트로 X, 미션 선택 O: \(result)")
                    self.missionCollectionView.isHidden = false
                }
            } else {
//                if result.todayMission == nil {
//                    // 히스트로 O, 미션 선택 X
//                    print("=== 히스트로 O, 미션 선택 X: \(result)")
//                    self.missionCollectionView.isHidden = true
//                    self.emptyImageView.isHidden = false
//                } else {
//                    // 히스트로 O, 미션 선택 O
//                    self.missionCollectionView.isHidden = true
//                    self.emptyImageView.isHidden = false
//                }
                self.missionCollectionView.isHidden = true
            }

        }
    }
}
