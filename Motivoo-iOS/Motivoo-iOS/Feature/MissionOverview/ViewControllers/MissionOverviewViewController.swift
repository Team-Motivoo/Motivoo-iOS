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
//        let homeViewController = HomeViewController()
//        if let navigationController = self.navigationController {
//            navigationController.pushViewController(homeViewController, animated: true)
//        } else {
//            print("Navigation controller is nil")
//        }
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestOverviewAPI()

    }

    // MARK: - Override Functions
    
    override func setUI() {
        noCompleteView.do {
            $0.isHidden = true
        }
    }
    
    override func setHierachy() {
        self.view.addSubviews(missionOverviewView, noCompleteView)
        //        self.view.addSubview(noCompleteView)
        
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OverViewCollectionViewCell.cellIdentifier, for: IndexPath()) as? OverViewCollectionViewCell else {return UICollectionViewCell()}
            
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
            
            let currentOverView = mission?.missionHistory?[indexPath.row]
            let oppoentStatusChip = currentOverView?.opponentStatusBadge
            print(myStatusChip)
            print(oppoentStatusChip)
            switch myStatusChip {
            case "진행중":
                if mission?.missionHistory?[indexPath.row].myImage == nil {
                    cell.myExerciseImageView.setPlaceholderText(TextLiterals.MissionOverview.noImg)
                }
                cell.myStatusBadgeContainerView.addSubview(cell.myDoingBadge)
                cell.myDoingBadge.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
                
            case "실패":
                if mission?.missionHistory?[indexPath.row].myImage == nil {
                    addFailurePlaceholder(to: cell.myExerciseImageView)
                }
                cell.myStatusBadgeContainerView.addSubview(cell.myFailBadge)
                cell.myFailBadge.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
                
                func addFailurePlaceholder(to imageView: UIImageView) {
                    let failureIcon = UIImageView(image: ImageLiterals.icon.thumb)
                    failureIcon.contentMode = .center
                    
                    let placeholderLabel = UILabel()
                    placeholderLabel.text = TextLiterals.MissionOverview.fail
                    placeholderLabel.textColor = .gray500
                    placeholderLabel.numberOfLines = 2
                    let placeholderStackView = UIStackView()
                    placeholderStackView.axis = .vertical
                    placeholderStackView.alignment = .center
                    placeholderStackView.spacing = 8
                    
                    placeholderStackView.addArrangedSubview(failureIcon)
                    placeholderStackView.addArrangedSubview(placeholderLabel)
                    
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
                if mission?.missionHistory?[indexPath.row].opponentImage == nil {
                    cell.opponentExerciseImageVIew.setPlaceholderText(TextLiterals.MissionOverview.noImg)
                }
                cell.opponentStatusContainerView.addSubview(cell.opponentDoingBadge)
                cell.opponentDoingBadge.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
            case "실패":
                if mission?.missionHistory?[indexPath.row].opponentImage == nil {
                    addFailurePlaceholder(to: cell.opponentExerciseImageVIew)
                }
                cell.opponentStatusContainerView.addSubview(cell.myFailBadge)
                cell.myFailBadge.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
                
                func addFailurePlaceholder(to imageView: UIImageView) {
                    let failureIcon = UIImageView(image: ImageLiterals.icon.thumb)
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
                cell.opponentStatusContainerView.addSubview(cell.opponentSuccessBadge)
                cell.opponentSuccessBadge.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
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
            self.mission = result
            print(self.mission)
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



