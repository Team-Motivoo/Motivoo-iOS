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
    private let backButton = UIButton()
    private let exerciseInfoLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
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
        self.addSubview(backButton)
        self.addSubview(exerciseInfoLabel)
        self.addSubview(tableView)
    }
    
     func setLayout() {
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.adjusted)
            $0.leading.equalToSuperview().inset(20.adjusted)
        }
        exerciseInfoLabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.top)
            $0.leading.equalTo(backButton.snp.trailing).offset(109.adjusted)
            
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(exerciseInfoLabel.snp.bottom).offset(40.adjusted)
            $0.leading.trailing.equalToSuperview()        }
    }
}
