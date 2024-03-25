//
//  DisclosureTableViewCell.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/9/24.
//

import UIKit

import SnapKit
import Then

class DisclosureTableViewCell: UITableViewCell {
        
    static let identifier = "DisclosureTableViewCell"
    let arrowIconImageView = UIImageView()
    let version = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
//        self.selectionStyle = .none
        setHierachy()
        setLayout()
        setUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        arrowIconImageView.isHidden = false
        version.isHidden = true
    }
    
    func setUI() {
        arrowIconImageView.do{
            $0.image = ImageLiterals.icon.rightArrow
        }
        
        version.do {
            $0.font = .body6
            $0.text = TextLiterals.MyPage.version
            $0.textColor = .gray900
            $0.isHidden = true
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierachy() {
        contentView.addSubviews(arrowIconImageView, version)

    }
    func setLayout() {
        arrowIconImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.adjusted)
        }
        
        version.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(26.adjusted)
        }
    }
}


