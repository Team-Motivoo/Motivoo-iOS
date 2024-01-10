//
//  DisclosureTableViewCell.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/9/24.
//

import UIKit

import SnapKit
import Then

class SectionTitleTableViewCell: UITableViewCell {
    
    private let AppInfoTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setHierachy()
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI() {
        AppInfoTitleLabel.do{
            $0.text = TextLiterals.MyPage.appInfo
            $0.font = .caption2
            $0.textColor = .gray500
        }
    }
    func setHierachy() {
        contentView.addSubview(AppInfoTitleLabel)
    }
    func setLayout() {
        AppInfoTitleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    
}
