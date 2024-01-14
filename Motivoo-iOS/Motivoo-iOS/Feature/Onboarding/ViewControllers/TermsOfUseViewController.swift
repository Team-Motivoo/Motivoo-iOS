//
//  TermsOfUseViewController.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/14/24.
//

import UIKit

import SafariServices
import SnapKit
import Then

final class TermsOfUseViewController: BaseViewController {

    private let termsOfUseView = TermsOfUseView()

    var termsOfListButton: Int = 0 {
        didSet {
            if (termsOfListButton == 3) {
                termsOfUseView.checkButton.isSelected = true
            } else {
                termsOfUseView.checkButton.isSelected = false
            }
        }
    }

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = TextLiterals.Onboarding.Terms.title
        self.navigationItem.leftBarButtonItem?.isHidden = false

        termsOfUseView.termsTableView.dataSource = self
        termsOfUseView.termsTableView.delegate = self
        termsOfUseView.termsTableView.separatorStyle = .none
    }

    // MARK: - Override Functions

    override func setHierachy() {
        self.view.addSubviews(termsOfUseView)
    }

    override func setLayout() {
        termsOfUseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setButtonEvent() {
        termsOfUseView.checkButton.addTarget(self, action: #selector(checkButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc
    func checkButtonDidTap(_ sender: UIButton) {
        if (!sender.isSelected) {
            sender.isSelected = true
            if (!(sender.accessibilityIdentifier == "allCheckButton")) {
                termsOfListButton += 1
            } else {
                let indexPaths = [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0)]
                for indexPath in indexPaths {
                    if let cell = termsOfUseView.termsTableView.cellForRow(at: indexPath) as? TermsOfUseTableViewCell {
                        cell.checkButton.isSelected = true
                    }
                }
                termsOfListButton = 3
            }
        } else {
            sender.isSelected = false
            if (!(sender.accessibilityIdentifier == "allCheckButton")) {
                termsOfListButton -= 1
            } else {
                let indexPaths = [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0)]
                for indexPath in indexPaths {
                    if let cell = termsOfUseView.termsTableView.cellForRow(at: indexPath) as? TermsOfUseTableViewCell {
                        cell.checkButton.isSelected = false
                    }
                }
                termsOfListButton = 0
            }
        }
    }

    @objc
    func seeTermsOfUse() {
        let notionUrl = NSURL(string: "https://www.notion.so/gayeong04/7f6097380a0b43d38ae265ea985152e7?pvs=4")
        let notionSafariView: SFSafariViewController = SFSafariViewController(url: notionUrl as! URL)
        self.present(notionSafariView, animated: true, completion: nil)
    }

    @objc
    func seeInfoCollection() {
        let notionUrl = NSURL(string: "https://www.notion.so/gayeong04/iOS-dc7e5c4540df40a298dba1ed15ef45d6?pvs=4")
        let notionSafariView: SFSafariViewController = SFSafariViewController(url: notionUrl as! URL)
        self.present(notionSafariView, animated: true, completion: nil)
    }

    @objc
    func seeInfoHandling() {
        let notionUrl = NSURL(string: "https://www.notion.so/gayeong04/Plan-0714f852799742d286ffe012b09262db?pvs=4")
        let notionSafariView: SFSafariViewController = SFSafariViewController(url: notionUrl as! URL)
        self.present(notionSafariView, animated: true, completion: nil)
    }
}

extension TermsOfUseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = termsOfUseView.termsTableView.dequeueReusableCell(withIdentifier: "TermsOfUseTableViewCell", for: indexPath) as? TermsOfUseTableViewCell else { return UITableViewCell() }
        if (indexPath.row == 1) {
            cell.setCell(term: TextLiterals.Onboarding.Terms.termsOfInfoCollection)
            cell.seeButton.addTarget(self, action: #selector(seeInfoCollection), for: .touchUpInside)
        } else if (indexPath.row == 2) {
            cell.setCell(term: TextLiterals.Onboarding.Terms.termsOfInfoHangling)
            cell.seeButton.addTarget(self, action: #selector(seeInfoHandling), for: .touchUpInside)
        }
        else {
            cell.seeButton.addTarget(self, action: #selector(seeTermsOfUse), for: .touchUpInside)
        }
        cell.checkButton.addTarget(self, action: #selector(checkButtonDidTap), for: .touchUpInside)
        return cell
    }
}

