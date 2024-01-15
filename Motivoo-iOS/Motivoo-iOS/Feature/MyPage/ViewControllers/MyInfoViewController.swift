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
    
    private var exerciseInfoDummy: [ExerciseInfo] = [ExerciseInfo(title: TextLiterals.MyPage.name, info: "김뿡뿡"),
                                                     ExerciseInfo(title: TextLiterals.MyPage.age, info: "54")]
    // MARK: - UI Components
    
    let myInfoView = MyInfoView()
    private var nextButton = UIButton()
    private let logoutPopupView = LeavePopupView()
    
    
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
            return exerciseInfoDummy.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionTitleTableViewCell.cellIdentifier) as? SectionTitleTableViewCell else {return UITableViewCell()}
            cell.configureCell(title: exerciseInfoDummy[indexPath.row].title, info: exerciseInfoDummy[indexPath.row].info)
            print("cell: \(indexPath.row)")
            cell.selectionStyle = .none
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
            leavePopupViewController.modalTransitionStyle = .coverVertical
            leavePopupViewController.modalPresentationStyle = .overFullScreen
            self.present(leavePopupViewController, animated: true)
        }
        if indexPath.section == 2 {
            let leavePopupViewController = LeaveViewController()
            leavePopupViewController.popupConfigureCell(title: TextLiterals.MyPage.realLeave, subtitle: TextLiterals.MyPage.leaveSubtitle, buttonTitle: TextLiterals.MyPage.leaveTitle)
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
}
