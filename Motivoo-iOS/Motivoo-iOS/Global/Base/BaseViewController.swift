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

    var swipeRecognizer: UISwipeGestureRecognizer!

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
        setBackSwipeGesture()
        customBackButton.addTarget(self, action: #selector(backViewController), for: .touchUpInside)
        view.backgroundColor = .white
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
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray900, NSAttributedString.Key.font: UIFont.heading7]
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customBackButton)
    }

    @objc func backViewController(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    func setBackSwipeGesture() {
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeRecognizer.direction = .right
        self.view.addGestureRecognizer(swipeRecognizer)
    }

    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func validateResult(_ result: NetworkResult<Any>) -> Any?{
        switch result{
        case .success(let data):
            print("성공했습니다.")
            print("⭐️⭐️⭐️⭐️⭐️⭐️")
            print(data)
            return data
        case .requestErr(let message):
            print(message)
        case .pathErr:
            print("path 혹은 method 오류입니다.🤯")
        case .serverErr:
            print("서버 내 오류입니다.🎯")
        case .networkFail:
            print("네트워크가 불안정합니다.💡")
        case .decodedErr:
            print("디코딩 오류가 발생했습니다.🕹️")
        case .authorizationFail(_):
            print("인증 오류가 발생했습니다. 다시 로그인해주세요🔐")
        }
        return nil
    }
}
