
//  ViewController.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit

import SnapKit
import Then

final class MyPageView: BaseView {
    
    // MARK: - UI Components
    
    private let parentLabel = UILabel()
    private let childLabel = UILabel()
    var nameLabel = UILabel()
    let myInfoButton = UIButton()
    
    func configureNameLabel(with text: String) {
          nameLabel.text = text
      }
    
    // MARK: - Override Functions
    
    override func setUI() {
        parentLabel.do{
            $0.text = TextLiterals.MyPage.parent
            $0.textColor = .gray900
            $0.font = .body5
        }
        childLabel.do{
            $0.text = TextLiterals.MyPage.child
            $0.textColor = .gray900
            $0.font = .body5
        }
        nameLabel.do{
            $0.textColor = .gray900
            $0.font = .heading3
        }
        myInfoButton.do{
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 18 //버튼 width/4
            $0.setTitle("내 정보", for: .normal)
            $0.setTitleColor(.gray700, for: .normal)
            $0.titleLabel?.font = .body6
        }
    }
    let tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .clear
        $0.separatorColor = .gray100
        $0.separatorStyle = .singleLine
        $0.sectionHeaderTopPadding = 1
        $0.layer.cornerRadius = 8
        $0.tableHeaderView = .init(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        if #available(iOS 15, *) {
            $0.sectionHeaderTopPadding = 1
        }
    }
    private var nextButton = UIButton()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray100
    }
    // MARK: - Override Functions
    override func setHierachy() {
        self.addSubviews(parentLabel,nameLabel,myInfoButton,tableView)
    }
    
    override func setLayout() {
        parentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(82.adjusted)
            $0.leading.equalToSuperview().inset(30.adjusted)
        }
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(parentLabel.snp.bottom).offset(3.adjusted)
            $0.leading.equalTo(parentLabel.snp.leading)
            
        }
        myInfoButton.snp.makeConstraints{
            $0.width.equalTo(72.adjusted)
            $0.height.equalTo(36.adjusted)
            $0.trailing.equalToSuperview().inset(20.adjusted)
            $0.centerY.equalTo(nameLabel)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(myInfoButton.snp.bottom).offset(35.adjusted)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(131.adjusted)
        }
    }
    
}
