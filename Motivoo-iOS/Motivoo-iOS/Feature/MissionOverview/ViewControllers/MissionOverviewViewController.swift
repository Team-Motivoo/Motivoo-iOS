
//
//  MissionOverviewViewController.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/05.
//

import UIKit

import SnapKit
import Then

final class MissionOverviewViewController: BaseViewController {
    
    //    // MARK: - Properties
    
    var mission: OverViewResponse? {
        didSet {
            missionOverviewView.collectionView.reloadData()
            print("ddddð")
        }
    }
  

    // MARK: - UI Components
    
    lazy var missionOverviewView = MissionOverviewView()
    lazy var noCompleteView = NoCompleteView()
    let overViewCell = OverViewCollectionViewCell()
    let bigMissionCell = LabelCollectionViewCell()
    static let identifier: String = "ImageCollectionViewCell"
    
    private func setCollectionViewConfig() {
        missionOverviewView.collectionView.register(LabelCollectionViewCell.self,
                                                    forCellWithReuseIdentifier: LabelCollectionViewCell.identifier)
        missionOverviewView.collectionView.register(OverViewCollectionViewCell.self,
                                                    forCellWithReuseIdentifier: OverViewCollectionViewCell.identifier)
        missionOverviewView.collectionView.delegate = self
        missionOverviewView.collectionView.dataSource = self
    }
    

    override func setButtonEvent() {
        noCompleteView.goExerciseButton.addTarget(self, action: #selector(goExerciseButtonDidTapped), for: .touchUpInside)
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

    // MARK: - Life Cycles
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewConfig()
        print("==viewDidLoad==")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestOverviewAPI()
        print("==viewWillAppear==")
        missionOverviewView.collectionView.reloadData()
    }

    // MARK: - Override Functions
    
    override func setUI() {
        noCompleteView.do {
            $0.isHidden = true
        }
    }
    
    override func setHierachy() {
        self.view.addSubviews(missionOverviewView, noCompleteView)
    }
    
    override func setLayout() {
        missionOverviewView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        noCompleteView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


//// MARK: -ImageViewController
extension MissionOverviewViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            print("=== section == 0")
            return 1
        } else {
            return mission?.missionHistory?.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.cellIdentifier, for: indexPath) as? LabelCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            
            if let todayMissionTitle = mission?.todayMission?.missionContent {
                cell.todayMissionLabel.text = todayMissionTitle
                print(todayMissionTitle)
            }
            return cell
        }
        else {
            print("=== OverViewCollectionViewCell")
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OverViewCollectionViewCell.cellIdentifier, for: indexPath) as? OverViewCollectionViewCell else { return UICollectionViewCell() }
            
            let date = mission?.missionHistory?[indexPath.row].date ?? ""
            let myImage = mission?.missionHistory?[indexPath.row].myImage ?? ""
            let opponentImage = mission?.missionHistory?[indexPath.row].opponentImage ?? ""
            let myMission = mission?.missionHistory?[indexPath.row].myMission ?? ""
            let opponentMission = mission?.missionHistory?[indexPath.row].opponentMission ?? ""
            let myStatusChip = mission?.missionHistory?[indexPath.row].myStatusBadge ?? ""
            let opponentStatusChip = mission?.missionHistory?[indexPath.row].opponentStatusBadge ?? ""
            
            
            cell.collectionViewConfigureCell(date: date,
                                             myImage: myImage,
                                             opponentImage: opponentImage,
                                             myMission: myMission,
                                             opponentMission: opponentMission,
                                             myStatusChip: myStatusChip,
                                             opponentStatusChip: opponentStatusChip)
            
       
            switch myStatusChip {
            case "진행중":
                if !cell.myStatusBadgeContainerView.subviews.isEmpty {
                     cell.myStatusBadgeContainerView.subviews.forEach { $0.removeFromSuperview() }
                 }
                cell.myExerciseImageView.image = UIImage(named: "img_mission_doing")
                cell.myStatusBadgeContainerView.addSubview(cell.myDoingBadge)
                cell.myDoingBadge.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
                
            case "실패":
                if !cell.myStatusBadgeContainerView.subviews.isEmpty {
                     cell.myStatusBadgeContainerView.subviews.forEach { $0.removeFromSuperview() }
                 }
                cell.myExerciseImageView.image = UIImage(named: "img_mission_fail")
                cell.myStatusBadgeContainerView.addSubview(cell.myFailBadge)
                cell.myFailBadge.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }

            case "성공":
                if !cell.myStatusBadgeContainerView.subviews.isEmpty {
                     cell.myStatusBadgeContainerView.subviews.forEach { $0.removeFromSuperview() }
                 }
                cell.myStatusBadgeContainerView.addSubview(cell.mySuccessBadge)
                cell.mySuccessBadge.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
            case "없음":
                cell.myStatusBadgeContainerView.isHidden = true

            default:
                cell.myExerciseImageView.image = UIImage(named: "img_mission_doing")
            }
            switch opponentStatusChip {
            case "진행중":
                if !cell.opponentStatusContainerView.subviews.isEmpty {
                     cell.opponentStatusContainerView.subviews.forEach { $0.removeFromSuperview() }
                 }
                cell.opponentExerciseImageVIew.image = UIImage(named: "img_mission_doing")
                cell.opponentStatusContainerView.addSubview(cell.opponentDoingBadge)
                cell.opponentDoingBadge.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
            case "실패":
                cell.opponentExerciseImageVIew.image = UIImage(named: "img_mission_fail")
                cell.opponentStatusContainerView.addSubview(cell.opponentFailBadge)
                cell.opponentFailBadge.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
            case "성공":
                cell.opponentStatusContainerView.addSubview(cell.opponentSuccessBadge)
                cell.opponentSuccessBadge.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
            case "없음":
                cell.opponentStatusContainerView.isHidden = true

            default:
                cell.opponentExerciseImageVIew.image = UIImage(named: "img_mission_doing")
            }
            if mission?.userType == "자녀" {
                cell.whoContainerView.addSubview(cell.parentExerciseBadge)
                cell.parentExerciseBadge.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
            }
            else{
                cell.whoContainerView.addSubview(cell.childExerciseBadge)
                cell.childExerciseBadge.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 226.adjusted)
        case 1:
            return CGSize(width: collectionView.bounds.width, height: 320.adjusted)
        default:
            return CGSize(width: collectionView.bounds.width, height: 0)
        }
    }
    func requestOverviewAPI() {
        OverviewAPI.shared.getMission()  { result in
            guard let result = self.validateResult(result) as? OverViewResponse else {
                return
            }
            self.missionOverviewView.collectionView.reloadData()
            self.mission = result
            if self.mission?.missionHistory?.isEmpty ?? true {
                // 미션 히스토리가 비어 있을 때
                self.noCompleteView.isHidden = false
                self.missionOverviewView.isHidden = true
            } else {
                // 미션 히스토리가 비어 있지 않을 때
                self.noCompleteView.isHidden = true
                self.missionOverviewView.isHidden = false
            }
            
        }
    }
}
