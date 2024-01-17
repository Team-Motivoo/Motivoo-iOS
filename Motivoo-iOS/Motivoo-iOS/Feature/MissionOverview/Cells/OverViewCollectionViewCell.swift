//
//  OverViewCollectionViewCell.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/12/24.
//

import UIKit

final class OverViewCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let dateLabel = UILabel()
    let myExerciseImageView = UIImageView()
    let opponentExerciseImageVIew = UIImageView()
    private let myMissionLabel = UILabel()
    private let opponentMissionLabel = UILabel()
    let noPlaceholderText = UILabel()
    let nextPlacehoderTextLabel = UILabel()
    let thumpIconImageView = UIImageView()
    let myExerciseBadge = BasePaddingLabel()
    let parentExerciseBadge = BasePaddingLabel()
    let myDoingBadge = BasePaddingLabel()
    let opponentDoingBadge = BasePaddingLabel()
    let myFailBadge = BasePaddingLabel()
    let opponentFailBadge = BasePaddingLabel()
    let mySuccessBadge = BasePaddingLabel()
    let opponentSuccessBadge = BasePaddingLabel()
    let childExerciseBadge = BasePaddingLabel()
    let myStatusBadge = BasePaddingLabel()
    let opponentStatusBadge = BasePaddingLabel()
    let myStatusBadgeContainerView = UIView()
    let opponentStatusContainerView = UIView()
    let whoContainerView = UIView()
    var badges: [BasePaddingLabel] = []
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setUI()
        setHierachy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        badges = [myDoingBadge, opponentDoingBadge, myFailBadge, opponentFailBadge, mySuccessBadge, opponentSuccessBadge, myExerciseBadge]
        
        dateLabel.do {
            $0.font = .body6
            $0.textColor = .gray600
        }
        
        myExerciseImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
            $0.backgroundColor = .gray100
            $0.contentMode =  .scaleAspectFill
        }
        
        myMissionLabel.do {
            $0.font = .body1
            $0.textColor = .gray900
            $0.numberOfLines = 2
        }
        
        thumpIconImageView.do {
            $0.image = ImageLiterals.icon.thumb
        }
        
        myExerciseBadge.do {
            $0.backgroundColor = .gray100
            $0.text = TextLiterals.MissionOverview.Myexercise
            $0.font = .caption2
            $0.textColor = .gray600
        }
        
        myDoingBadge.do {
            $0.backgroundColor = .pink100
            $0.text = TextLiterals.MissionOverview.doing
            $0.font = .caption2
            $0.textColor = .pink
        }
        
        opponentDoingBadge.do {
            $0.backgroundColor = .pink100
            $0.text = TextLiterals.MissionOverview.doing
            $0.font = .caption2
            $0.textColor = .pink
        }
        
        myFailBadge.do {
            $0.backgroundColor = .gray300
            $0.text = TextLiterals.MissionOverview.onlyfail
            $0.font = .caption2
            $0.textColor = .gray700
        }
        
        opponentFailBadge.do {
            $0.backgroundColor = .gray300
            $0.text = TextLiterals.MissionOverview.onlyfail
            $0.font = .caption2
            $0.textColor = .gray700
        }
        
        mySuccessBadge.do {
            $0.backgroundColor = .blue100
            $0.text = TextLiterals.MissionOverview.onlysuccess
            $0.font = .caption2
            $0.textColor = .blue600
        }
        
        opponentSuccessBadge.do {
            $0.backgroundColor = .blue100
            $0.text = TextLiterals.MissionOverview.onlysuccess
            $0.font = .caption2
            $0.textColor = .blue600
        }
        
        parentExerciseBadge.do {
            $0.backgroundColor = .gray100
            $0.text = TextLiterals.MissionOverview.parentExercise
            $0.font = .caption2
            $0.textColor = .gray600
        }
        
        opponentExerciseImageVIew.do {
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .gray100
            $0.clipsToBounds = true
            $0.contentMode =  .scaleAspectFill
        }
        
        opponentMissionLabel.do {
            $0.font = .body1
            $0.textColor = .gray900
            $0.numberOfLines = 2
            $0.clipsToBounds = true
        }
        
        childExerciseBadge.do {
            $0.backgroundColor = .gray100
            $0.text = TextLiterals.MissionOverview.childExercise
            $0.font = .caption2
            $0.textColor = .gray600
        }
        
        myStatusBadgeContainerView.do {
            $0.backgroundColor = .clear
        }
        
        opponentStatusContainerView.do {
            
            $0.backgroundColor = .clear
        }
        
        whoContainerView.do {
            $0.backgroundColor = .clear
        }
    }
    func setHierachy() {
        myExerciseImageView.addSubview(noPlaceholderText)
        contentView.addSubviews(dateLabel,myExerciseImageView,myMissionLabel,opponentExerciseImageVIew,opponentMissionLabel,myExerciseBadge,myStatusBadgeContainerView,whoContainerView,opponentStatusContainerView)
    }
    func setLayout() {
        contentView.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(291)
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.top.equalToSuperview()
        }
        myExerciseImageView.snp.makeConstraints {
            $0.width.equalTo(164.adjusted)
            $0.height.equalTo(164.adjusted)
            $0.top.equalTo(dateLabel.snp.bottom).offset(8.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        myMissionLabel.snp.makeConstraints {
            $0.leading.equalTo(myExerciseImageView.snp.leading)
            $0.top.equalTo(myExerciseImageView.snp.bottom).offset(8.adjusted)
        }
        myExerciseBadge.snp.makeConstraints {
            $0.top.equalTo(myMissionLabel.snp.bottom).offset(6.adjusted)
            $0.leading.equalTo(myExerciseImageView.snp.leading)
        }
        myStatusBadgeContainerView.snp.makeConstraints {
            $0.top.equalTo(myMissionLabel.snp.bottom).offset(6.adjusted)
            $0.leading.equalTo(myExerciseBadge.snp.trailing).offset(4.adjusted)
        }
        opponentExerciseImageVIew.snp.makeConstraints {
            $0.width.equalTo(164.adjusted)
            $0.height.equalTo(164.adjusted)
            $0.top.equalTo(myExerciseImageView.snp.top)
            $0.leading.equalTo(myExerciseImageView.snp.trailing).offset(7.adjusted)
        }
        opponentMissionLabel.snp.makeConstraints {
            $0.leading.equalTo(opponentExerciseImageVIew.snp.leading)
            $0.top.equalTo(opponentExerciseImageVIew.snp.bottom).offset(8.adjusted)
        }
        whoContainerView.snp.makeConstraints {
            $0.top.equalTo(opponentMissionLabel.snp.bottom).offset(6.adjusted)
            $0.leading.equalTo(opponentExerciseImageVIew.snp.leading)
        }
        opponentStatusContainerView.snp.makeConstraints {
            $0.top.equalTo(opponentMissionLabel.snp.bottom).offset(6.adjusted)
            $0.leading.equalTo(whoContainerView.snp.trailing).offset(4.adjusted)
        }
    }
    
    // MARK: - collectionViewConfigureCell
    
    func collectionViewConfigureCell(date: String, myImage: String, opponentImage: String, myMission: String, opponentMission: String, myStatusChip: String, opponentStatusChip: String){
        dateLabel.text = date
        myExerciseImageView.kfSetImage(url: myImage)
        opponentExerciseImageVIew.kfSetImage(url: opponentImage)
        myMissionLabel.text = myMission
        opponentMissionLabel.text = opponentMission
        myStatusBadge.text = myStatusChip
        opponentStatusBadge.text = opponentStatusChip
    }
}
