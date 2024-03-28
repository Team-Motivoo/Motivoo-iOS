//
//  CollectionHeaderCell.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 3/25/24.
//

import UIKit

import SnapKit
import Then

class CollectionHeaderCell: UICollectionViewCell {

    private let backgroundImageView = UIImageView()
    private let todayLabel = UILabel()
    private let exerciseLabel = UILabel()

    let mySection = UIView()
    let myMissionBG = UIImageView()
    let myToolTipView = ToolTipView(title: "운동 중", textColor: .gray700, backgroundColor: .gray100, isTopTip: false)
    let myIcon = UIImageView()
    private let myMissionBorder = UIImageView()

    let partnerSection = UIView()
    let partnerMissionBG = UIImageView()
    let partnerToolTipView = ToolTipView(title: "운동 중", textColor: .gray700, backgroundColor: .gray100, isTopTip: false)
    let partnerIcon = UIImageView()
    private let partnerMissionBorder = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setUI()
        setHierachy()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI() {
        backgroundImageView.do {
            $0.image = ImageLiterals.img.missionHeaderBackground
        }
        todayLabel.do {
            $0.font = .body1
            $0.textColor = .gray600
            $0.text = TextLiterals.MissionOverview.todayExercise
        }
        exerciseLabel.do {
            $0.font = .heading4
            $0.textColor = .gray900
            $0.textAlignment = .left
            $0.numberOfLines = 2
            $0.text = "8천걸음 걷고\n스탠딩 랫폴다운 20번 하기"
        }

        myMissionBG.do {
            $0.image = ImageLiterals.img.whiteTodayMission
        }
        myIcon.do {
            $0.image = ImageLiterals.img.myProfile
        }
        myMissionBorder.do {
            $0.image = ImageLiterals.img.missionBorder
        }

        partnerMissionBG.do {
            $0.image = ImageLiterals.img.whiteTodayMission
        }
        partnerIcon.do {
            $0.image = ImageLiterals.img.partnerProfile
        }
        partnerMissionBorder.do {
            $0.image = ImageLiterals.img.missionBorder
        }
    }

    func setHierachy() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubviews(todayLabel, exerciseLabel, mySection, partnerSection)
        mySection.addSubviews(myMissionBG, myIcon, myMissionBorder, myToolTipView)
        partnerSection.addSubviews(partnerMissionBG, partnerIcon, partnerMissionBorder, partnerToolTipView)
    }

    func setLayout() {
        backgroundImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(-90.adjusted)
            $0.leading.equalToSuperview()
            $0.height.equalTo(411.adjusted)
            $0.width.equalTo(375.adjusted)
        }
        todayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(76.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        exerciseLabel.snp.makeConstraints {
            $0.top.equalTo(todayLabel.snp.bottom).offset(6.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }

        mySection.snp.makeConstraints {
            $0.top.equalTo(exerciseLabel.snp.bottom).offset(18.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.width.equalTo(164.adjusted)
            $0.height.equalTo(210.adjusted)
        }
        myMissionBG.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(164.adjusted)
            $0.height.equalTo(180.adjusted)
        }
        myToolTipView.snp.makeConstraints {
            $0.bottom.equalTo(myIcon.snp.top).offset(-8)
            $0.centerX.equalToSuperview()
        }
        myIcon.snp.makeConstraints {
            $0.top.equalTo(myMissionBG.snp.top).offset(150.adjusted)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(60.adjusted)
        }
        myMissionBorder.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(164.adjusted)
            $0.height.equalTo(210.adjusted)
        }

        partnerSection.snp.makeConstraints {
            $0.top.equalTo(exerciseLabel.snp.bottom).offset(18.adjusted)
            $0.trailing.equalToSuperview().inset(20.adjusted)
            $0.width.equalTo(164.adjusted)
            $0.height.equalTo(210.adjusted)
        }
        partnerMissionBG.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(164.adjusted)
            $0.height.equalTo(180.adjusted)
        }
        partnerToolTipView.snp.makeConstraints {
            $0.bottom.equalTo(myIcon.snp.top).offset(-4)
            $0.centerX.equalToSuperview()
        }
        partnerIcon.snp.makeConstraints {
            $0.top.equalTo(myMissionBG.snp.top).offset(150.adjusted)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(60.adjusted)
        }
        partnerMissionBorder.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(164.adjusted)
            $0.height.equalTo(210.adjusted)
        }
    }

    func setMySection(_ myIconImage: UIImage, _ myMissionImage: UIImage){
        self.myIcon.image = myIconImage
    }
}
