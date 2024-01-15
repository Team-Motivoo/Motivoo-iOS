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

    let customBackButton: UIButton = {
        let button = UIButton()
        button.setTitle("이전", for: .normal)
        button.setTitleColor(.gray700, for: .normal)
        button.titleLabel?.font = .body6
        return button
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
        //customNavigationBar()
        setupNavigationBar()
        customBackButton.addTarget(self, action: #selector(backViewController), for: .touchUpInside)
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

    func makeBarButtonItem<T: UIView>(with view: T) -> UIBarButtonItem {
        return UIBarButtonItem(customView: view)
    }

    func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .gray100
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray900, NSAttributedString.Key.font: UIFont.heading7]
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customBackButton)
    }

    @objc func backViewController(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
