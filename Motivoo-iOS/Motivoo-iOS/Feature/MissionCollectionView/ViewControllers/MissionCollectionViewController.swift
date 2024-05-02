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
            if self.missionHistory?.todayMission != nil {
                self.historyCount -= 1
            }
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
            $0.isHidden = true
        }
        emptyImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(440.adjusted)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(120.adjusted)
        }
    }
    
    // MARK: - Actions
    
    override func setButtonEvent() {
        self.missionEmptyView.goExerciseButton.addTarget(self, action: #selector(goExerciseButtonDidTapped), for: .touchUpInside)
    }
    
    @objc private func goExerciseButtonDidTapped() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        guard let delegate = sceneDelegate else {
            print("sceneDelegate가 할당 Error")
            return
        }
        let rootViewController = UINavigationController(rootViewController: MotivooTabBarController())
        delegate.window?.rootViewController = rootViewController
    }
}

extension MissionCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if historyCount > 0 {
            self.missionCollectionView.isHidden = false
        } else if historyCount > 1 {
            self.emptyImageView.isHidden = true
        }
        return historyCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        var adjustedIndex = indexPath.row
        
        if missionHistory?.todayMission != nil {
            adjustedIndex += 1
        }
        
        let date = missionHistory?.missionHistory[adjustedIndex]?.date ?? ""
        let myImage = missionHistory?.missionHistory[adjustedIndex]?.myMissionImgURL ?? nil
        let myMission = missionHistory?.missionHistory[adjustedIndex]?.myMissionContent ?? ""
        let myStatus = missionHistory?.missionHistory[adjustedIndex]?.myMissionStatus ?? ""
        let partnerImage = missionHistory?.missionHistory[adjustedIndex]?.opponentMissionImgURL ?? nil
        let partnerMission = missionHistory?.missionHistory[adjustedIndex]?.opponentMissionContent ?? ""
        let partnerStatusChip = missionHistory?.missionHistory[adjustedIndex ]?.opponentMissionStatus ?? ""
        
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
            header.goExerciseButton.addTarget(self, action: #selector(goExerciseButtonDidTapped), for: .touchUpInside)
            
            header.changeIcon(missionHistory?.userType, missionHistory?.opponentUserType)

            if missionHistory?.todayMission == nil {
                // today 미션 없으면 버튼 반환
                header.setNotTodayMission()
            } else {
                // today 미션 있으면
                header.setTodayMission(todatMission: missionHistory?.todayMission?.missionContent ?? "")
                let todayMission = missionHistory?.missionHistory[0]
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
            
            if result.missionHistory.count == 0 {
                if result.todayMission == nil {
                    // 히스트로 X, 미션 선택 X./
                    print("=== 히스트로 X, 미션 선택 X: \(result)")
                    self.missionCollectionView.isHidden = true
                    self.missionEmptyView.isHidden = false
                    self.emptyImageView.isHidden = true
                } else {
                    // 히스트로 X, 미션 선택 O
                    print("=== 히스트로 X, 미션 선택 O: \(result)")
                    self.missionCollectionView.isHidden = false
                    self.emptyImageView.isHidden = false
                }
            } else if result.missionHistory.count == 1 {
                if result.todayMission != nil {
                    print("처음 미션 선택해서 히스토리는 없는 경우")
                    self.missionCollectionView.isHidden = false
                    self.emptyImageView.isHidden = false
                } else {
                    print("어제 미션 선택해서 히스토리 하나 있는 경우")
                    self.missionCollectionView.isHidden = false
                    self.emptyImageView.isHidden = true
                }
            } else {
                self.missionCollectionView.isHidden = false
                self.emptyImageView.isHidden = true
            }
        }
    }
}
