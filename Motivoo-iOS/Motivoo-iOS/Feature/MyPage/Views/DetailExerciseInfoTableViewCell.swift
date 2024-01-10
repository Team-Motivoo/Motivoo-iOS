//
//  DetailExerciseInfoTableViewCell.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/11/24.
//

import UIKit

import SnapKit
import Then

final class DetailExerciseInfoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private let BackButton = UIButton()
    private let ExerciseInfoLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
//        self.selectionStyle = .none
        setHierachy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycles
    
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
    
    // MARK: - Override Functions
     func setHierachy() {
        self.addSubview(BackButton)
        self.addSubview(ExerciseInfoLabel)
        self.addSubview(tableView)
    }
    
     func setLayout() {
        BackButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        ExerciseInfoLabel.snp.makeConstraints{
            $0.top.equalTo(BackButton.snp.top)
            $0.leading.equalTo(BackButton.snp.trailing).offset(109.adjusted)
            
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(ExerciseInfoLabel.snp.bottom).offset(40.adjusted)
            $0.leading.trailing.equalToSuperview()        }
    }
    // MARK: - 이 곳은 위의 오버라이드 함수 영역과 구분될 수 있도록 자유로운 마크주석을 달아주세요
    
}
