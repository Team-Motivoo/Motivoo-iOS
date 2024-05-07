//
//  CollectionViewCell.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 3/30/24.
//

import UIKit

import SnapKit
import Then

final class CollectionViewCell: UICollectionViewCell {

    private let dateLabel = UILabel()

    private let myImage = UIImageView()
    private let myExerciseLabel = UILabel()
    private let myExerciseTag = BasePaddingLabel()
    private let mySuccessTag = BasePaddingLabel()

    private let partnerImage = UIImageView()
    private let partnerExerciseLabel = UILabel()
    private let partnerExerciseTag = BasePaddingLabel()
    private let partnerSuccessTag = BasePaddingLabel()

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
        dateLabel.do {
            $0.font = .body6
            $0.textColor = .gray500
            $0.text = "0000년 00월 00일 0요일"
        }
        myImage.do {
            $0.image = ImageLiterals.img.nextExercise
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
        }
        myExerciseLabel.do {
            $0.font = .body1
            $0.textColor = .gray900
            $0.numberOfLines = 3
            $0.text = "Test 미션입니다.\n 6000 걸음 걷기"
        }
        myExerciseTag.do {
            $0.backgroundColor = .gray100
            $0.text = TextLiterals.MissionOverview.Myexercise
            $0.font = .caption2
            $0.textColor = .gray600
        }
        mySuccessTag.do {
            $0.backgroundColor = .purple50
            $0.text = TextLiterals.MissionOverview.onlysuccess
            $0.font = .caption2
            $0.textColor = .purple400
        }
        partnerImage.do {
            $0.image = ImageLiterals.img.nextExercise
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
        }
        partnerExerciseLabel.do {
            $0.font = .body1
            $0.textColor = .gray900
            $0.numberOfLines = 3
            $0.text = "Test 미션입니다.\n 6000 걸음 걷기"
        }
        partnerExerciseTag.do {
            $0.backgroundColor = .gray100
            $0.text = TextLiterals.MissionOverview.partnerExercise
            $0.font = .caption2
            $0.textColor = .gray600
        }
        partnerSuccessTag.do {
            $0.backgroundColor = .purple50
            $0.text = TextLiterals.MissionOverview.onlysuccess
            $0.font = .caption2
            $0.textColor = .purple400
        }
    }

    func setHierachy() {
        contentView.addSubviews(dateLabel, myImage, myExerciseLabel, myExerciseTag, mySuccessTag,
                    partnerImage, partnerExerciseLabel, partnerExerciseTag, partnerSuccessTag)
    }

    func setLayout() {
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(336.adjusted)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        myImage.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8.adjusted)
            $0.leading.equalToSuperview()
            $0.size.equalTo(164.adjusted)
        }
        myExerciseLabel.snp.makeConstraints {
            $0.top.equalTo(myImage.snp.bottom).offset(8.adjusted)
            $0.leading.equalToSuperview()
            $0.width.equalTo(164.adjusted)
        }
        myExerciseTag.snp.makeConstraints {
            $0.top.equalTo(myExerciseLabel.snp.bottom).offset(6.adjusted)
            $0.leading.equalToSuperview()
        }
        mySuccessTag.snp.makeConstraints {
            $0.top.equalTo(myExerciseLabel.snp.bottom).offset(8.adjusted)
            $0.leading.equalTo(myExerciseTag.snp.trailing).offset(4.adjusted)
        }
        partnerImage.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8.adjusted)
            $0.leading.equalTo(myImage.snp.trailing).offset(7.adjusted)
            $0.size.equalTo(164.adjusted)
        }
        partnerExerciseLabel.snp.makeConstraints {
            $0.top.equalTo(partnerImage.snp.bottom).offset(8.adjusted)
            $0.leading.equalTo(myImage.snp.trailing).offset(7.adjusted)
            $0.width.equalTo(164.adjusted)
        }
        partnerExerciseTag.snp.makeConstraints {
            $0.top.equalTo(partnerExerciseLabel.snp.bottom).offset(6.adjusted)
            $0.leading.equalTo(myImage.snp.trailing).offset(7.adjusted)
        }
        partnerSuccessTag.snp.makeConstraints {
            $0.top.equalTo(partnerExerciseLabel.snp.bottom).offset(8.adjusted)
            $0.leading.equalTo(partnerExerciseTag.snp.trailing).offset(4.adjusted)
        }
    }

    func setMissionHistory(date: String, myImage: String?, myMission: String, mySuccess: String, partnerImage: String?, partnerMission: String, partnerSuccess: String) {
        self.dateLabel.text = date

        if myImage != nil {
            self.myImage.kfSetImage(url: myImage)
        }
        self.myExerciseLabel.text = myMission
        if mySuccess != "성공" {
            self.mySuccessTag.isHidden = true
        }

        if partnerImage != nil {
            self.partnerImage.kfSetImage(url: partnerImage)
        }
        self.partnerExerciseLabel.text = partnerMission
        if partnerSuccess != "성공" {
            self.partnerSuccessTag.isHidden = true
        }
    }
}

