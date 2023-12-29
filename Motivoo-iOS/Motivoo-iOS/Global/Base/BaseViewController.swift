//
//  BaseViewController.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy private(set) var className: String = {
      return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    // MARK: - init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEINIT: \(className)")
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setHierachy()
        setLayout()
        setButtonEvent()
        view.backgroundColor = .systemBackground

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
    
    func setButtonEvent() {
        /// Override Point
        /// addTarget과 같은 버튼이벤트를 연결해주는 코드를 작성합니다.
    }
}
