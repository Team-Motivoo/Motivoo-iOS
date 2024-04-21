//
//  CollectionHeaderCell.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 3/25/24.
//

import UIKit

import SnapKit
import Then

final class CollectionHeaderCell: UICollectionViewCell {

    private let backgroundImageView = UIImageView()
    private let todayLabel = UILabel()
    private let exerciseLabel = UILabel()
    let goExerciseButton = UIButton()
    private let goExerciseLabel = UILabel()
    private let goExerciseIcon = UIImageView()

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

    private let collectionTitle = UILabel()
    let questionButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setUI()
        setHierarchy()
        setLayout()
        setButtonEvent()
        self.goExerciseButton.isUserInteractionEnabled = true
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
        goExerciseButton.do {
            $0.backgroundColor = .gray900
            $0.layer.cornerRadius = 8
        }
        goExerciseLabel.do {
            $0.font = .heading4
            $0.textColor = .white
            $0.textAlignment = .left
            $0.numberOfLines = 1
            $0.text = TextLiterals.NoComplete.goSelectExercise2
        }
        goExerciseIcon.do {
            $0.image = ImageLiterals.icon.thickRightArrow
        }

        myMissionBG.do {
            $0.image = ImageLiterals.img.whiteTodayMission
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
        }
        myIcon.do {
            $0.image = ImageLiterals.img.myProfile
        }
        myMissionBorder.do {
            $0.image = ImageLiterals.img.missionBorder
        }

        partnerMissionBG.do {
            $0.image = ImageLiterals.img.whiteTodayMission
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
        }
        partnerIcon.do {
            $0.image = ImageLiterals.img.partnerProfile
        }
        partnerMissionBorder.do {
            $0.image = ImageLiterals.img.missionBorder
        }

        collectionTitle.do {
            $0.text = TextLiterals.MissionOverview.collectionExercise
            $0.font = .heading5
            $0.textColor = .gray900
            $0.textAlignment = .left
            $0.numberOfLines = 1
        }
        questionButton.do {
            $0.setImage(ImageLiterals.icon.question, for: .normal)
        }
    }

    func setHierarchy() {
        contentView.addSubviews(backgroundImageView, collectionTitle, goExerciseButton, questionButton)
        contentView.bringSubviewToFront(goExerciseButton)
        backgroundImageView.addSubviews(todayLabel, exerciseLabel, mySection, partnerSection)
        goExerciseButton.addSubviews(goExerciseLabel, goExerciseIcon)
        mySection.addSubviews(myMissionBG, myIcon, myMissionBorder, myToolTipView)
        partnerSection.addSubviews(partnerMissionBG, partnerIcon, partnerMissionBorder, partnerToolTipView)
    }

    func setLayout() {
        backgroundImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(-94.adjusted)
            $0.leading.equalToSuperview()
            $0.height.equalTo(400.adjusted)
            $0.width.equalTo(375.adjusted)
        }
        todayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(76.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        exerciseLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(102.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        goExerciseButton.snp.makeConstraints {
            $0.top.equalTo(todayLabel.snp.bottom).offset(6.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.width.equalTo(235.adjusted)
            $0.height.equalTo(36.adjusted)
        }
        goExerciseLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10.adjusted)
        }
        goExerciseIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(goExerciseLabel.snp.trailing).offset(4.adjusted)
            $0.size.equalTo(14.adjusted)
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
            $0.bottom.equalTo(myIcon.snp.top)
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
            $0.bottom.equalTo(myIcon.snp.top)
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

        collectionTitle.snp.makeConstraints {
            $0.top.equalTo(backgroundImageView.snp.bottom).offset(32.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        questionButton.snp.makeConstraints {
            $0.top.equalTo(backgroundImageView.snp.bottom).offset(32.adjusted)
            $0.leading.equalTo(collectionTitle.snp.trailing).offset(8.adjusted)
        }
    }

    func setButtonEvent() {
        self.questionButton.addTarget(self, action: #selector(showToolTip), for: .touchUpInside)
    }

    @objc private func showToolTip() {
        let toolTipImageView = UIImageView()
        toolTipImageView.do {
            $0.image = ImageLiterals.img.historyToolTip
            $0.contentMode = .scaleAspectFill
        }

        backgroundImageView.addSubview(toolTipImageView)

        toolTipImageView.snp.makeConstraints {
            $0.top.equalTo(questionButton.snp.bottom).offset(4.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.width.equalTo(281.adjusted)
            $0.height.equalTo(64.adjusted)
        }

        UIView.animate(withDuration: 2.0, delay: 0.8, options: .curveEaseOut, animations: {
            toolTipImageView.alpha = 0.0
        }, completion: {(isCompleted) in
            toolTipImageView.removeFromSuperview()
        })
    }

    func setTodayMission(todatMission: String) {
        self.todayLabel.text = TextLiterals.MissionOverview.todayExercise
        self.exerciseLabel.text = todatMission
        self.exerciseLabel.isHidden = false
        self.goExerciseButton.isHidden = true
        self.myToolTipView.isHidden = false
        self.partnerToolTipView.isHidden = false
    }

    func setNotTodayMission() {
        self.todayLabel.text = TextLiterals.NoComplete.goSelectExercise
        self.goExerciseButton.isHidden = false
        self.exerciseLabel.isHidden = true
        self.myToolTipView.isHidden = true
        self.partnerToolTipView.isHidden = true
    }

    func setTodaySection(myMissionImage: String?, myStatus: String, partnerMissionImage: String?, partnerStatus: String){
        if myMissionImage != nil {
            self.myMissionBG.kfSetImage(url: myMissionImage)
        }
        if myStatus == "성공" {
            myToolTipView.updateTitle(text: TextLiterals.MissionOverview.onlySuccess)
        }
        if partnerMissionImage != nil {
            self.partnerMissionBG.kfSetImage(url: partnerMissionImage)
        }
        if myStatus == "성공" {
            partnerToolTipView.updateTitle(text: TextLiterals.MissionOverview.onlySuccess)
        }
    }

    func changeIcon() {
        self.myIcon.image = ImageLiterals.img.myProfile2
        self.partnerIcon.image = ImageLiterals.img.partnerProfile2
    }
}
