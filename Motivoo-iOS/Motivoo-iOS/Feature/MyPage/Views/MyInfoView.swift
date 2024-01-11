//
//  MyInfoView.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/11/24.
//

import UIKit

import SnapKit
import Then

final class MyInfoView: BaseView {
    
    // MARK: - UI Components
    
    let myInfotableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .clear
        $0.separatorColor = .gray100
        $0.separatorStyle = .singleLine
        $0.sectionHeaderTopPadding = 0
        $0.layer.cornerRadius = 8
        $0.tableHeaderView = .init(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        if #available(iOS 15, *) {
            $0.sectionHeaderTopPadding = 1
        }
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray100
    }
    
    // MARK: - Override Functions
    
    override func setHierachy() {
        self.addSubview(myInfotableView)
    }
    
    override func setUI() {
    }
    
    override func setLayout() {
        myInfotableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20.adjusted)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
