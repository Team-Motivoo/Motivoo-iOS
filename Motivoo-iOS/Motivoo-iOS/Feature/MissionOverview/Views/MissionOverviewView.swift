//
//  MissionOverviewView.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/11/24.
//


import UIKit

import SnapKit
import Then

final class MissionOverviewView: BaseView {
    
    // MARK: - UI Components
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .white
    }
    
    
    // MARK: - Override Functions
    
    override func setHierachy() {
        self.addSubview(collectionView)
    }
    
    override func setUI() {
    }
    
    override func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}
