//
//  ViewController.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2023/12/29.
//

import UIKit

import SafariServices
import SnapKit
import Then

final class MyPageViewController: BaseViewController {
    
    // MARK: - UI Components
//    private let notionUrl = NSURL(string: AppInfoLink[Int])
    let mypageView = MyPageView()
    private var nextButton = UIButton()
    
    let AppInfoLink: [String] = [TextLiterals.Onboarding.Terms.termOfUserURL , TextLiterals.Onboarding.Terms.termOfInfoHandlingURL , TextLiterals.MyPage.opensource, TextLiterals.MyPage.developer]
    
    
    var userInfo: MyInfoUserResponse? {
        didSet {
            myInfoView.myInfotableView.reloadData()
            mypageView.tableView.reloadData()
        }
    }
    
    let myInfoView = MyInfoView()
    
    private func setTableViewConfig() {
        mypageView.tableView.register(ExerciseInfoTableViewCell.self,
                                      forCellReuseIdentifier: ExerciseInfoTableViewCell.cellIdentifier)
        mypageView.tableView.register(TitleTableViewCell.self,
                                      forCellReuseIdentifier: TitleTableViewCell.cellIdentifier)
        mypageView.tableView.register(SectionTitleTableViewCell.self,
                                      forCellReuseIdentifier: SectionTitleTableViewCell.cellIdentifier)
        mypageView.tableView.register(DisclosureTableViewCell.self,
                                      forCellReuseIdentifier: DisclosureTableViewCell.cellIdentifier)
        mypageView.tableView.delegate = self
        mypageView.tableView.dataSource = self
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        requestMyAPI()
    }
    
    // MARK: - Override Functions
    
    override func setHierachy() {
        self.view.addSubview(mypageView)
    }
    
    override func setLayout() {
        mypageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        mypageView.myInfoButton.addTarget(self, action: #selector(myInfoButtonDidTapped), for: .touchUpInside)
    }
    
    // MARK: - Custom Method
    
    @objc
    private func myInfoButtonDidTapped() {
        let myInfoViewController = MyInfoViewController()
        myInfoViewController.dataBind(data: self.userInfo ?? MyInfoUserResponse(userNickname: "", userAge: 0, userType: ""))
        navigationController?.pushViewController(myInfoViewController, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - UITableViewDelegate

extension MyPageViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return TextLiterals.MyPage.AppInfoItems.count+1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            let exerciseInfoViewController = ExerciseInfoViewController()
            navigationController?.pushViewController(exerciseInfoViewController, animated: true)
            
        case 1:
            let notionUrlString = AppInfoLink[indexPath.row - 1]
            if let notionUrl = NSURL(string: notionUrlString) {
                let notionSafariView = SFSafariViewController(url: notionUrl as URL)
                present(notionSafariView, animated: true, completion: nil)
            }
            
        case 2:
            let kakaoUrlString = TextLiterals.MyPage.kakao
            if let notionUrl = NSURL(string: kakaoUrlString) {
                let notionSafariView = SFSafariViewController(url: notionUrl as URL)
                present(notionSafariView, animated: true, completion: nil)
            }
            
            // FIXME: - 모티부 더 알아보기 링크 나오면 수정
        case 3:
            let kakaoUrlString = TextLiterals.MyPage.learnMoreLink
            if let notionUrl = NSURL(string: kakaoUrlString) {
                let notionSafariView = SFSafariViewController(url: notionUrl as URL)
                present(notionSafariView, animated: true, completion: nil)
            }
            
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseInfoTableViewCell", for: indexPath)
            
        case 1:
            if indexPath.row == 0{
                cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath)
            } else if indexPath.row == 4 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DisclosureTableViewCell.identifier,
                                                                                for: indexPath) as? DisclosureTableViewCell else { return UITableViewCell() }
                cell.textLabel?.text = "\(TextLiterals.MyPage.AppInfoItems[indexPath.row-1])"
                cell.textLabel?.font = UIFont.heading7
                cell.textLabel?.textColor = .gray900
                cell.selectionStyle = .none
                cell.arrowIconImageView.isHidden = true
                cell.version.isHidden = false
                cell.isUserInteractionEnabled = false
                return cell
            } else{
                cell = tableView.dequeueReusableCell(withIdentifier: "DisclosureTableViewCell", for: indexPath)
                cell.textLabel?.text = "\(TextLiterals.MyPage.AppInfoItems[indexPath.row-1])"
                cell.textLabel?.font = UIFont.heading7
                cell.textLabel?.textColor = .gray900
            }
            
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "DisclosureTableViewCell", for: indexPath)
            cell.textLabel?.text = "\(TextLiterals.MyPage.ToKakaoChannel)"
            cell.textLabel?.font = UIFont.heading7
            cell.textLabel?.textColor = .gray900
            
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "DisclosureTableViewCell", for: indexPath)
            cell.textLabel?.text = "\(TextLiterals.MyPage.learnMore)"
            cell.textLabel?.font = UIFont.heading7
            cell.textLabel?.textColor = .gray900
            
        default:
            cell = UITableViewCell()
        }

        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 90.adjusted
        case 1:
            if indexPath.row == 0 {
                return 46.adjusted
            } else{
                return 66.adjusted
            }
        case 2, 3:
            return 64.adjusted
        default:
            return UITableView.automaticDimension
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
extension MyPageViewController {
    func requestMyAPI() {
        MyAPI.shared.getMyInfo() { result in
            guard let result = self.validateResult(result) as? MyInfoUserResponse else {
                print(result)
                return
            }
            print(result)
            self.userInfo = result
            self.mypageView.nameLabel.text = result.userNickname
            print(self.userInfo)
            if self.userInfo?.userType == "자녀" {
                self.mypageView.parentLabel.text = TextLiterals.MyPage.child
            } else {
                self.mypageView.parentLabel.text = TextLiterals.MyPage.parent
            }
        }
    }
}
