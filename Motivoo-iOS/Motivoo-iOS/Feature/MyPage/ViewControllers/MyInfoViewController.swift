//
//  MyInfoViewController.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/11/24.
//

import UIKit

import SnapKit
import Then

final class MyInfoViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var userInfo: MyInfoUserResponse? {
        didSet {
            myInfoView.myInfotableView.reloadData()
        }
    }
    
    // MARK: - UI Components
    
    let myInfoView = MyInfoView()
    private var nextButton = UIButton()
    private let logoutPopupView = LeavePopupView()
    let mypageView = MyPageView()
    
    private func setTableViewConfig() {
        myInfoView.myInfotableView.register(SectionTitleTableViewCell.self,
                                            forCellReuseIdentifier: SectionTitleTableViewCell.cellIdentifier)
        myInfoView.myInfotableView.register(DisclosureTableViewCell.self,
                                            forCellReuseIdentifier: DisclosureTableViewCell.cellIdentifier)
        myInfoView.myInfotableView.register(LeaveTableViewCell.self,
                                            forCellReuseIdentifier: LeaveTableViewCell.cellIdentifier)
        myInfoView.myInfotableView.dataSource = self
        myInfoView.myInfotableView.delegate = self
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewConfig()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Override Functions
    override func setHierachy() {
        self.view.addSubview(myInfoView)
    }
    
    override func setLayout() {
        myInfoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension MyInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionTitleTableViewCell.cellIdentifier) as? SectionTitleTableViewCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            if indexPath.row == 0 {
                cell.configureCell(title: TextLiterals.MyPage.name, info: userInfo?.userNickname ?? String())
            } else if indexPath.row == 1 {
                
                guard let age = userInfo?.userAge else { return UITableViewCell() }
                cell.configureCell(title: TextLiterals.MyPage.age, info: "\(age)")
            }
            return cell
        }
        else if indexPath.section == 1 {
            let cell: UITableViewCell
            cell = tableView.dequeueReusableCell(withIdentifier: DisclosureTableViewCell.cellIdentifier, for: indexPath)
            cell.textLabel?.text = TextLiterals.MyPage.logout
            cell.textLabel?.font = UIFont.heading7
            cell.textLabel?.textColor = .gray900
            cell.selectionStyle = .none
            
            return cell
        }
        else{
            let cell: UITableViewCell
            cell = tableView.dequeueReusableCell(withIdentifier: LeaveTableViewCell.cellIdentifier, for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let leavePopupViewController = LeaveViewController()
            leavePopupViewController.popupConfigureCell(title: TextLiterals.MyPage.logout, subtitle: TextLiterals.MyPage.realLogout, buttonTitle: TextLiterals.MyPage.logout)
            leavePopupViewController.popupView.blackButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
            leavePopupViewController.modalTransitionStyle = .coverVertical
            leavePopupViewController.modalPresentationStyle = .overFullScreen
            self.present(leavePopupViewController, animated: true)
        }
        if indexPath.section == 2 {
            let leavePopupViewController = LeaveViewController()
            leavePopupViewController.popupConfigureCell(title: TextLiterals.MyPage.realLeave, subtitle: TextLiterals.MyPage.leaveSubtitle, buttonTitle: TextLiterals.MyPage.leaveTitle)
            leavePopupViewController.popupView.blackButton.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
            leavePopupViewController.modalTransitionStyle = .coverVertical
            leavePopupViewController.modalPresentationStyle = .overFullScreen
            self.present(leavePopupViewController, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return 88.adjusted
        default:
            return 64.adjusted
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let clearView = UIView()
        
        clearView.do {
            $0.backgroundColor = .clear
        }
        
        return clearView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let clearView = UIView()
        
        clearView.do {
            $0.backgroundColor = .clear
        }
        
        return clearView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 16.adjusted
        }
    }
    func dataBind(data: MyInfoUserResponse) {
        self.userInfo = data
    }
    
    @objc private func logout() {
        // 서버에 로그아웃 요청
        MyAPI.shared.postLogout() { result in
            guard let result = self.validateResult(result) as? SimpleResponse else { return }
            
            print(result)
            TokenManager.shared.removeToken()
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            guard let delegate = sceneDelegate else {
                print("sceneDelegate가 할당 Error")
                return
            }
            let rootViewController = UINavigationController(rootViewController: SplashViewController())
            delegate.window?.rootViewController = rootViewController
        }
    }
    @objc private func deleteUser() {
        MyAPI.shared.deleteLeave() { result in
            guard let result = self.validateResult(result) as? SimpleResponse else {
                return
            }
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            guard let delegate = sceneDelegate else {
                print("sceneDelegate가 할당 Error")
                return
            }
            let rootViewController = UINavigationController(rootViewController: SplashViewController())
            delegate.window?.rootViewController = rootViewController
        }
    }
}
