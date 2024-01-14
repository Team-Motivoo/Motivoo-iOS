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
        
    private let arrowIconImageView = UIImageView()
    
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
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierachy() {
        contentView.addSubview(arrowIconImageView)

    }
    func setLayout() {
        arrowIconImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.adjusted)
        }
    }
}


