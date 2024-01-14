//
//  AuthorizationViewController.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/14/24.
//

import UIKit

import SnapKit
import Then

final class AuthorizationViewController: BaseViewController {

    private let authorizationView = AuthorizationView()

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
    }

    // MARK: - Override Functions

    override func setupNavigationBar() {
        super.setupNavigationBar()

        self.navigationController?.navigationBar.topItem?.title = TextLiterals.Onboarding.Authorization.title
        self.navigationItem.leftBarButtonItem?.isHidden = true
    }

    override func setHierachy() {
        self.view.addSubviews(authorizationView)
    }

    override func setLayout() {
        authorizationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setButtonEvent() {
        authorizationView.allowButton.addTarget(self, action: #selector(allowButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Actions

    func setDelegate() {
        authorizationView.authorizatioTableView.dataSource = self
        authorizationView.authorizatioTableView.delegate = self
        authorizationView.authorizatioTableView.separatorStyle = .none
    }

    @objc
    func allowButtonDidTap() {
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
}

extension AuthorizationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = authorizationView.authorizatioTableView.dequeueReusableCell(withIdentifier: "AuthorizationTableViewCell", for: indexPath) as? AuthorizationTableViewCell else { return UITableViewCell() }
        if (indexPath.row == 1) {
            cell.setCell(icon: ImageLiterals.img.cameraCircle, title: TextLiterals.Onboarding.Authorization.camera, subtitle: TextLiterals.Onboarding.Authorization.cameraLabel)
        } else if (indexPath.row == 2) {
            cell.setCell(icon: ImageLiterals.img.galleryCircle, title: TextLiterals.Onboarding.Authorization.picture, subtitle: TextLiterals.Onboarding.Authorization.pictureLabel)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78.adjusted
    }
}