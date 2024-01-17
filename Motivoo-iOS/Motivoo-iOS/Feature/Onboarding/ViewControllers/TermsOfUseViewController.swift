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
                isButtonEnabled = true
            } else {
                termsOfUseView.checkButton.isSelected = false
                isButtonEnabled = false
            }
        }
    }

    var isButtonEnabled: Bool = false {
        didSet {
            if isButtonEnabled {
                termsOfUseView.nextButton.setTitleColor(.white, for: .normal)
                termsOfUseView.nextButton.backgroundColor = .gray900
            } else {
                termsOfUseView.nextButton.setTitleColor(.gray400, for: .normal)
                termsOfUseView.nextButton.backgroundColor = .gray100
            }
            termsOfUseView.nextButton.isEnabled = isButtonEnabled
        }
    }

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        setNextButton()
    }

    // MARK: - Override Functions
    override func setupNavigationBar() {
        super.setupNavigationBar()

        self.navigationController?.navigationBar.topItem?.title = TextLiterals.Onboarding.Terms.title
        self.navigationItem.leftBarButtonItem?.isHidden = false
    }

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
        termsOfUseView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Actions

    func setDelegate() {
        termsOfUseView.termsTableView.dataSource = self
        termsOfUseView.termsTableView.delegate = self
        termsOfUseView.termsTableView.separatorStyle = .none
    }

    func setNextButton() {
        termsOfUseView.nextButton.setTitleColor(.gray400, for: .normal)
        termsOfUseView.nextButton.backgroundColor = .gray100
        termsOfUseView.nextButton.isEnabled = false
    }


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
        let notionUrl = NSURL(string: TextLiterals.Onboarding.Terms.termOfUserURL)
        let notionSafariView: SFSafariViewController = SFSafariViewController(url: notionUrl! as URL)
        self.present(notionSafariView, animated: true, completion: nil)
    }

    @objc
    func seeInfoCollection() {
        let notionUrl = NSURL(string: TextLiterals.Onboarding.Terms.termOfInfoCollectionURL)
        let notionSafariView: SFSafariViewController = SFSafariViewController(url: notionUrl! as URL)
        self.present(notionSafariView, animated: true, completion: nil)
    }

    @objc
    func seeInfoHandling() {
        let notionUrl = NSURL(string: TextLiterals.Onboarding.Terms.termOfInfoHandlingURL)
        let notionSafariView: SFSafariViewController = SFSafariViewController(url: notionUrl! as URL)
        self.present(notionSafariView, animated: true, completion: nil)
    }

    @objc
    func nextButtonDidTap() {
        let startViewController = StartViewController()
        self.navigationController?.pushViewController(startViewController, animated: true)

        UserDefaultManager.shared.saveUserLoggedIn(login: true)
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.adjusted
    }
}

