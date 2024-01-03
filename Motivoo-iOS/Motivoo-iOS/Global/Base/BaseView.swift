//
//  BaseView.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit

class BaseView: UIView {
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierachy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions

    func setUI() {
        /// Override Point
        /// 컴포넌트의 UI 를 설정해주는 코드를 작성합니다.
    }
    
    func setHierachy() {
        /// Override Point
        /// View에 컴포넌트를 올리는 코드를 작성합니다. ex) addSubview
    }
    
    func setLayout() {
        /// Override Point
        /// 컴포넌트 간의 레이아웃을 잡는 코드를 작성합니다.
    }
}

