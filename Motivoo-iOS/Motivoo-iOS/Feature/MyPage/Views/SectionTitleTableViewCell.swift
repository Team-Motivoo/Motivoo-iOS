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
    private let InfoLabel = UILabel()
    
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
            $0.font = .caption2
            $0.textColor = .gray700
        }
        InfoLabel.do{
            $0.font = .heading7
            $0.textColor = .gray900
        }
    }
    func setHierachy() {
        contentView.addSubviews(AppInfoTitleLabel,InfoLabel)
    }
    func setLayout() {
        AppInfoTitleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(20.adjusted)
            $0.centerY.equalToSuperview()
        }
        InfoLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.adjusted)
        }
    }
    
    func configureCell(title: String, info: String) {
        AppInfoTitleLabel.text = title
        InfoLabel.text = info
    }
}
