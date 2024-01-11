//
//  LeaveTableViewCell.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/11/24.
//

import UIKit

import SnapKit
import Then

class LeaveTableViewCell: UITableViewCell {
        
    private let arrowIconImageView = UIImageView()
    private let leaveLabel = UILabel()
    private let leaveDiscriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
//        self.selectionStyle = .none
        setHierachy()
        setLayout()
        setUI()
    }
    
    func setUI() {
        arrowIconImageView.do{
            $0.image = ImageLiterals.icon.rightArrow
        }
        leaveLabel.do{
            $0.text = TextLiterals.MyPage.leave
            $0.textColor = .gray900
            $0.font = .heading6 // 이거도 heafding7로 바꾸기
        }
        leaveDiscriptionLabel.do{
            $0.text = TextLiterals.MyPage.leaveDescription
            $0.textColor = .gray500
            $0.font = .caption2
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierachy() {
        contentView.addSubviews(leaveLabel,arrowIconImageView,leaveDiscriptionLabel)

    }
    func setLayout() {
        leaveLabel.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(20.adjusted)
        }
        arrowIconImageView.snp.makeConstraints{
            $0.top.equalTo(leaveLabel.snp.top)
            $0.trailing.equalToSuperview().inset(20.adjusted)
        }
        leaveDiscriptionLabel.snp.makeConstraints{
            $0.top.equalTo(leaveLabel.snp.bottom).offset(4.adjusted)
            $0.leading.equalTo(leaveLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(20.adjusted)
        }
    }
}


