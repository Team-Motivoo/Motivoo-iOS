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
    
    // MARK: - Properties
    private var overViewDummy: OverView = OverView(userType: "PARENT", todayMission: TodayMission(missionContent: "러닝머신 50분 달리기"), missionHistory: [MissionHistory(date: "2024년 1월 12일 금요일", myMission: "내미션1", myImage: "https://postfiles.pstatic.net/MjAyMzA3MTlfMTI3/MDAxNjg5NzA3ODIxNTk5.seJYSUpdX98ikS-9vymoCfYMKi9R4ZPtEJxaQ5vpqCcg.Cat1KiWm6yBea43XDZYiCrq6Leub8h4QdpET21C2LZsg.JPEG.hyori030/IMG_9798.jpg?type=w966", myStatusBadge: "성공", opponentMission: "상대미션1", opponentImage: "", opponentStatusBadge: "실패"),
                                                                                                                                                   MissionHistory(date: "2024년 1월 11일 목요일", myMission: "내미션2", myImage: "https://mblogthumb-phinf.pstatic.net/MjAyMjAyMDdfMjEy/MDAxNjQ0MTk0Mzk2MzY3.WAeeVCu2V3vqEz_98aWMOjK2RUKI_yHYbuZxrokf-0Ug.sV3LNWlROCJTkeS14PMu2UBl5zTkwK70aKX8B1w2oKQg.JPEG.41minit/1643900851960.jpg?type=w800", myStatusBadge: "성공", opponentMission: "상대미션2", opponentImage: "", opponentStatusBadge: "진행중")])
    
    let missionOverviewView = MissionOverviewView()
    let noCompleteView = NoCompleteView()
    let overViewCell = OverViewCollectionViewCell()
    
    static let identifier: String = "ImageCollectionViewCell"
    // MARK: - UI Components
    
    private func setCollectionViewConfig() {
        missionOverviewView.collectionView.register(LabelCollectionViewCell.self,
                                                    forCellWithReuseIdentifier: LabelCollectionViewCell.identifier)
        missionOverviewView.collectionView.register(OverViewCollectionViewCell.self,
                                                    forCellWithReuseIdentifier: OverViewCollectionViewCell.identifier)
        missionOverviewView.collectionView.delegate = self
        missionOverviewView.collectionView.dataSource = self
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewConfig()
        
        
    }
    
    // MARK: - Override Functions
    override func setHierachy() {
        self.view.addSubview(missionOverviewView)
        //        self.view.addSubview(noCompleteView)
        
    }
    
    override func setLayout() {
        missionOverviewView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
//    override func setButtonEvent() {
//        noCompleteView.goExerciseButton.addTarget(self, action: #selector(goExerciseButtonDidTapped), for: .touchUpInside)
//    }
//
//    // MARK: - Custom Method
//
//    @objc
//    private func goExerciseButtonDidTapped() {
//        let homeViewController = HomeViewController()
//        navigationController?.pushViewController(homeViewController, animated: true)
//        self.navigationController?.navigationBar.isHidden = false

// MARK: -ImageViewController
extension MissionOverviewViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 섹션의 수를 반환합니다. 여기서는 2개의 섹션을 사용하고 있습니다.
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            print("=== section == 0")
            return 1
        } else {
            print("=== OverViewDummy.count: \(overViewDummy.missionHistory.count)")
            return overViewDummy.missionHistory.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCollectionViewCell", for: indexPath)
            return cell
        }
        else {
            print("=== OverViewCollectionViewCell")
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OverViewCollectionViewCell.cellIdentifier, for: IndexPath()) as? OverViewCollectionViewCell else {return UICollectionViewCell()}
            
            
            cell.myExerciseImageView.image = nil
            cell.opponentExerciseImageVIew.image = nil
            
            cell.collectionViewConfigureCell(date: overViewDummy.missionHistory[indexPath.row].date,
                            myImage: overViewDummy.missionHistory[indexPath.row].myImage,
                            opponentImage: overViewDummy.missionHistory[indexPath.row].opponentImage,
                            myMission: overViewDummy.missionHistory[indexPath.row].myMission,
                            opponentMission: overViewDummy.missionHistory[indexPath.row].opponentMission,
                            myStatusChip: overViewDummy.missionHistory[indexPath.row].myStatusBadge,
                            opponentStatusChip: overViewDummy.missionHistory[indexPath.row].opponentStatusBadge)
            
            let currentOverView = overViewDummy.missionHistory[indexPath.row]
            let myStatusChip = currentOverView.myStatusBadge
            let oppoentStatusChip = currentOverView.opponentStatusBadge
            
            switch myStatusChip {
            case "진행중":
                if overViewDummy.missionHistory[indexPath.row].myImage == "" {
                    cell.myExerciseImageView.setPlaceholderText(TextLiterals.MissionOverview.noImg)
                    cell.myStatusBadgeContainerView.addSubview(cell.myDoingBadge)
                }
                cell.myStatusBadgeContainerView.addSubview(cell.myDoingBadge)
                cell.myDoingBadge.snp.makeConstraints{
                       $0.edges.equalToSuperview()
                   }
                
            case "실패":
                if overViewDummy.missionHistory[indexPath.row].myImage == "" {
                    addFailurePlaceholder(to: cell.myExerciseImageView)
                }
                cell.myStatusBadgeContainerView.addSubview(cell.myFailBadge)
                cell.myFailBadge.snp.makeConstraints{
                       $0.edges.equalToSuperview()
                   }

                
            // 실패 플레이스홀더와 아이콘을 추가하는 함수
            func addFailurePlaceholder(to imageView: UIImageView) {
                let failureIcon = UIImageView(image: UIImage(named: "thumb"))
                failureIcon.contentMode = .center

                let placeholderLabel = UILabel()
                placeholderLabel.text = TextLiterals.MissionOverview.fail
                placeholderLabel.textColor = .gray500
                placeholderLabel.numberOfLines = 2
                let placeholderStackView = UIStackView()
                placeholderStackView.axis = .vertical
                placeholderStackView.alignment = .center
                placeholderStackView.spacing = 8 // 실패 아이콘과 텍스트 사이의 간격 조절

                // 실패 아이콘과 텍스트를 스택뷰에 추가
                placeholderStackView.addArrangedSubview(failureIcon)
                placeholderStackView.addArrangedSubview(placeholderLabel)

                // 스택뷰를 셀의 이미지뷰에 추가
                imageView.addSubview(placeholderStackView)

                placeholderStackView.snp.makeConstraints {
                    $0.center.equalToSuperview()
                }
            }
            default:
                cell.myStatusBadgeContainerView.addSubview(cell.mySuccessBadge)
                cell.mySuccessBadge.snp.makeConstraints{
                       $0.edges.equalToSuperview()
                   }
            }
            switch oppoentStatusChip {
            case "진행중":
                if overViewDummy.missionHistory[indexPath.row].opponentImage == "" {
                    cell.opponentExerciseImageVIew.setPlaceholderText(TextLiterals.MissionOverview.noImg)
                }
                cell.opponentStatusContainerView.addSubview(cell.myDoingBadge)
                cell.myDoingBadge.snp.makeConstraints{
                       $0.edges.equalToSuperview()
                   }
            case "실패":
                if overViewDummy.missionHistory[indexPath.row].opponentImage == "" {
                    addFailurePlaceholder(to: cell.opponentExerciseImageVIew)
                }
                cell.opponentStatusContainerView.addSubview(cell.myFailBadge)
                cell.myFailBadge.snp.makeConstraints{
                       $0.edges.equalToSuperview()
                   }
                


            // 실패 플레이스홀더와 아이콘을 추가하는 함수
            func addFailurePlaceholder(to imageView: UIImageView) {
                let failureIcon = UIImageView(image: UIImage(named: "thumb"))
                failureIcon.contentMode = .center

                let placeholderLabel = UILabel()
                placeholderLabel.text = TextLiterals.MissionOverview.fail
                placeholderLabel.textColor = .gray500
                placeholderLabel.numberOfLines = 2
                let placeholderStackView = UIStackView()
                placeholderStackView.axis = .vertical
                placeholderStackView.alignment = .center
                placeholderStackView.spacing = 8 // 실패 아이콘과 텍스트 사이의 간격 조절

                // 실패 아이콘과 텍스트를 스택뷰에 추가
                placeholderStackView.addArrangedSubview(failureIcon)
                placeholderStackView.addArrangedSubview(placeholderLabel)

                // 스택뷰를 셀의 이미지뷰에 추가
                imageView.addSubview(placeholderStackView)

                placeholderStackView.snp.makeConstraints {
                    $0.center.equalToSuperview()
                }
                
            }
                
            default:
                if overViewDummy.missionHistory[indexPath.row].myImage == "" {
                    cell.myExerciseImageView.setPlaceholderText("기본")
                }
                if overViewDummy.missionHistory[indexPath.row].opponentImage == "" {
                    cell.opponentExerciseImageVIew.setPlaceholderText("기본")
                }
                cell.opponentStatusContainerView.addSubview(cell.opponentSuccessBadge)
                cell.opponentSuccessBadge.snp.makeConstraints{
                       $0.edges.equalToSuperview()
                   }
                
                
                
            }
            if overViewDummy.userType == "CHILD" {
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
            return CGSize(width: collectionView.bounds.width, height: 291.adjusted)
        default:
            return CGSize(width: collectionView.bounds.width, height: 0)
        }
    }
}



