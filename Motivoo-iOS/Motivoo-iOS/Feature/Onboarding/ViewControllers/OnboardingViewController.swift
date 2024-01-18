//
//  OnboardingViewControllerTest.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/11/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingViewController: BaseViewController {

    //MARK: - Properties

    lazy var choiceThreeButtonArray: [String] = []
    lazy var selectButtonName2: String = ""
    lazy var selectButtonName3: String = ""
    lazy var selectButtonName4: String = ""
    lazy var selectButtonName5: String = ""

    lazy var questionArray: [String: Any] = ["type": "", "age": 0, "isExercise": true,
                                             "exerciseType":"", "exerciseCount":"", "exerciseTime":"", "exerciseNote":""]

    var progressIndex: Float = 1.0 {
        didSet (progressIndex) {
            // print("=================progressIndex: \(progressIndex)")
            var step: Float = (progressIndex+1)/6
            if progressIndex < 0 {
                step = 1/6
            } else {
                step = (progressIndex+1)/6
            }
            onboardingProgressView.setProgress(step, animated: true)
            // print("=\(step)")
        }
    }

    // MARK: - UI Component

    private lazy var onboardingProgressView = UIProgressView()
    let onboardingCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.register(OnboardingView1Cell.self,
                                forCellWithReuseIdentifier: OnboardingView1Cell.identifier)
        collectionView.register(OnboardingView2Cell.self,
                                forCellWithReuseIdentifier: OnboardingView2Cell.identifier)
        collectionView.register(OnboardingView3Cell.self,
                                forCellWithReuseIdentifier: OnboardingView3Cell.identifier)
        collectionView.register(OnboardingView4Cell.self,
                                forCellWithReuseIdentifier: OnboardingView4Cell.identifier)
        collectionView.register(OnboardingView5Cell.self,
                                forCellWithReuseIdentifier: OnboardingView5Cell.identifier)
        collectionView.register(OnboardingView6Cell.self,
                                forCellWithReuseIdentifier: OnboardingView6Cell.identifier)
        return collectionView
    }()

    // MARK: - Life Cycles

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)

        setupNavigationBar()
        self.customBackButton.removeTarget(self, action: #selector(backViewController), for: .touchUpInside)
        self.customBackButton.addTarget(self, action: #selector(prevButtonDidTap), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)

        self.customBackButton.addTarget(self, action: #selector(backViewController), for: .touchUpInside)
        self.customBackButton.removeTarget(self, action: #selector(prevButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Override Functions

    override func setUI() {
        onboardingProgressView.do {
            $0.trackTintColor = .gray100  // progress 배경 색상
            $0.progressTintColor = .blue400  // progress 진행 색상
            $0.progress = 1/6
        }
    }

    override func setHierachy() {
        self.view.addSubviews(onboardingProgressView, onboardingCollectionView)
    }

    override func setLayout() {
        onboardingProgressView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(2.adjusted)
        }
        onboardingCollectionView.snp.makeConstraints {
            $0.top.equalTo(onboardingProgressView.snp.bottom).offset(44.adjusted)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.navigationController?.isNavigationBarHidden = false
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

    // MARK: - Actions

    func setDelegate() {
        self.onboardingCollectionView.delegate = self
        self.onboardingCollectionView.dataSource = self
    }

    @objc
    private func selectButtonDidTap2(_ sender: UIButton) {
        if (sender.isSelected) {
            if (selectButtonName2 == "") {
                // 버튼 선택
                selectButtonName2 = sender.accessibilityIdentifier ?? "Unknown"
                sender.isSelected = false
                if selectButtonName2 == "yes" {
                    questionArray["isExercise"] = true
                } else {
                    questionArray["isExercise"] = false
                }
            } else {
                let indexPath = IndexPath(row: 1, section: 0)
                if let cell = self.onboardingCollectionView.cellForItem(at: indexPath) as? OnboardingView2Cell {
                    if (selectButtonName2 == "no") { // no 지우고 yes 선택
                        cell.noButton.isSelected = true
                        cell.yesButton.isSelected = false
                    } else {
                        cell.noButton.isSelected = false
                        cell.yesButton.isSelected = true
                    }
                }
                selectButtonName2 = sender.accessibilityIdentifier ?? "Unknown"
            }
            if (selectButtonName2 == "yes") {
                TextLiterals.Onboarding.Q3.exerciseTitle = "평소 하는 운동을 알려주세요"
                TextLiterals.Onboarding.Q3.exercisePowerSubtitle = "운동 강도에 따라 선택해주세요"
                TextLiterals.Onboarding.Q3.highTitle = "고강도 운동"
                TextLiterals.Onboarding.Q3.highSubtitle = "등산, 에어로빅, 크로스핏, 헬스 등"
                TextLiterals.Onboarding.Q3.middleTitle = "중강도 운동"
                TextLiterals.Onboarding.Q3.middleSubtitle = "빠르게 걷기, 골프, 필라테스 등"
                TextLiterals.Onboarding.Q3.lowTitle = "저강도 운동"
                TextLiterals.Onboarding.Q3.lowSubtitle = "걷기, 요가, 스트레칭 등"
                TextLiterals.Onboarding.Q3.howManyExercise = "일주일에 운동을\n몇 번 하시나요?"
                TextLiterals.Onboarding.Q3.howLongExercise = "하루에 몇 시간 정도\n운동하시나요?"
            } else {
                TextLiterals.Onboarding.Q3.exerciseTitle = "일상생활 중 자주 하는\n활동을 알려주세요"
                TextLiterals.Onboarding.Q3.exercisePowerSubtitle = "가장 많이 하는 활동을 기준으로 선택해주세요"
                TextLiterals.Onboarding.Q3.highTitle = "고강도 활동"
                TextLiterals.Onboarding.Q3.highSubtitle = "무거운 물건 나르기, 육아 등"
                TextLiterals.Onboarding.Q3.middleTitle = "중강도 활동"
                TextLiterals.Onboarding.Q3.middleSubtitle = "가벼운 물건 나르기 등"
                TextLiterals.Onboarding.Q3.lowTitle = "저강도 활동"
                TextLiterals.Onboarding.Q3.lowSubtitle = "출퇴근, 가벼운 청소, 쇼핑 등"
                TextLiterals.Onboarding.Q3.howManyExercise = "해당 활동을 일주일에\n몇 번 하시나요?"
                TextLiterals.Onboarding.Q3.howLongExercise = "하루에 몇 시간 정도\n해당 활동을 하시나요?"
            }
            let indexPaths = [IndexPath(row: 2, section: 0), IndexPath(row: 3, section: 0), IndexPath(row: 4, section: 0), IndexPath(row: 5, section: 0)]
            self.onboardingCollectionView.reloadItems(at: indexPaths) // 해당 인덱스 경로의 셀을 새
            nextButtonDidTap()
        } else {
            sender.isSelected = true
            selectButtonName2 = ""
            questionArray["isExercise"] = nil
        }
    }

    @objc
    private func selectButtonDidTap3(_ sender: UIButton) {
        if (sender.isSelected) {
            if (selectButtonName3 == "") {
                // 버튼 선택
                sender.isSelected = false
            } else {
                let indexPath = IndexPath(row: 2, section: 0)
                if let cell = self.onboardingCollectionView.cellForItem(at: indexPath) as? OnboardingView3Cell {
                    if (selectButtonName3 == "high") { // 선택 되었던걸 true로 선택 취소
                        cell.highButton.isSelected = true
                    } else if (selectButtonName3 == "medium") {
                        cell.mediumButton.isSelected = true
                    }
                    else {
                        cell.lowButton.isSelected = true
                    }
                    sender.isSelected = false
                }
            }
            selectButtonName3 = sender.accessibilityIdentifier ?? "Unknown"
            if selectButtonName3 == "high" {
                questionArray["exerciseType"] = TextLiterals.Onboarding.Q3.highTitle
            } else if selectButtonName3 == "medium" {
                questionArray["exerciseType"] = TextLiterals.Onboarding.Q3.middleTitle
            } else {
                questionArray["exerciseType"] = TextLiterals.Onboarding.Q3.lowTitle
            }
            nextButtonDidTap()
        } else {
            sender.isSelected = true
            selectButtonName3 = ""
            questionArray["exerciseType"] = ""
        }
    }

    @objc
    private func selectButtonDidTap4(_ sender: UIButton) {
        if (sender.isSelected) {
            if (selectButtonName4 == "") {
                // 버튼 선택
                sender.isSelected = false
                questionArray["exerciseCount"] = sender.titleLabel?.text
            } else {
                let indexPath = IndexPath(row: 3, section: 0)
                if let cell = self.onboardingCollectionView.cellForItem(at: indexPath) as? OnboardingView4Cell {
                    if (selectButtonName4 == "1day") { // 선택 되었던걸 true로 선택 취소
                        cell.day1Button.isSelected = true
                    } else if (selectButtonName4 == "2day") {
                        cell.day2Button.isSelected = true
                    } else if (selectButtonName4 == "3day") {
                        cell.day3Button.isSelected = true
                    } else {
                        cell.day5Button.isSelected = true
                    }
                    sender.isSelected = false
                    questionArray["exerciseCount"] = sender.titleLabel?.text
                }
            }
            selectButtonName4 = sender.accessibilityIdentifier ?? "Unknown"
            nextButtonDidTap()
        } else {
            sender.isSelected = true
            selectButtonName4 = ""
            questionArray["exerciseCount"] = ""
        }
    }

    @objc
    private func selectButtonDidTap5(_ sender: UIButton) {
        if (sender.isSelected) {
            if (selectButtonName5 == "") {
                // 버튼 선택
                sender.isSelected = false
                questionArray["exerciseTime"] = sender.titleLabel?.text
            } else {
                let indexPath = IndexPath(row: 4, section: 0)
                if let cell = self.onboardingCollectionView.cellForItem(at: indexPath) as? OnboardingView5Cell {
                    if (selectButtonName5 == "thirtyMinutes") { // 선택 되었던걸 true로 선택 취소
                        cell.minutes30Button.isSelected = true
                    } else if (selectButtonName5 == "oneHour") {
                        cell.oneHourButton.isSelected = true
                    } else if (selectButtonName5 == "twoHour") {
                        cell.twoHourButton.isSelected = true
                    } else {
                        cell.twoHoueOverButton.isSelected = true
                    }
                    sender.isSelected = false
                    questionArray["exerciseTime"] = sender.titleLabel?.text
                }
            }
            selectButtonName5 = sender.accessibilityIdentifier ?? "Unknown"
            nextButtonDidTap()
        } else {
            sender.isSelected = true
            selectButtonName5 = ""
            questionArray["exerciseTime"] = ""
        }
    }

    @objc
    private func choiceMaxThreeButtonDidTap(_ sender: UIButton) {
        let indexPath = IndexPath(row: 5, section: 0)
        let cell = self.onboardingCollectionView.cellForItem(at: indexPath) as! OnboardingView6Cell
        if (sender.isSelected) {
            // print("=== 선택")
            if (choiceThreeButtonArray.count < 3) {
                sender.isSelected = false
                choiceThreeButtonArray.append(sender.accessibilityIdentifier ?? "Unknown")
                cell.startMotivooButton.isEnabled = true
                cell.isButtonEnabled = true
            }
        } else {
            sender.isSelected = true
            cell.startMotivooButton.isEnabled = false
            if (choiceThreeButtonArray.count <= 1) {
                cell.isButtonEnabled = false
            }
            nextButtonDidTap()
            // print("=== 선택 취소")
            if let index = choiceThreeButtonArray.firstIndex(of: sender.accessibilityIdentifier ?? "Unknown") {
                choiceThreeButtonArray.remove(at: index)
            }
        }
        // print("===choiceThreeButtonArray.count: \(choiceThreeButtonArray.count)")
    }

    @objc
    private func nextButtonDidTap() {
        // print("indexpath + 1")
        let currentIndexPath = self.onboardingCollectionView.indexPathsForVisibleItems.first
        if let currentIndexPath = currentIndexPath, currentIndexPath.row + 1 < self.onboardingCollectionView.numberOfItems(inSection: 0) {
            let nextIndexPath = IndexPath(row: currentIndexPath.row + 1, section: currentIndexPath.section)
            self.onboardingCollectionView.scrollToItem(at: nextIndexPath, at: .right, animated: true)
        }
        progressIndex = Float(currentIndexPath?.row ?? 0) + 2
        print("== 2 :\(progressIndex)")
    }

    @objc
    private func prevButtonDidTap() {
        // print("indexpath - 1")
        let currentIndexPath = self.onboardingCollectionView.indexPathsForVisibleItems.first
        if let currentIndexPath = currentIndexPath, currentIndexPath.row - 1 < self.onboardingCollectionView.numberOfItems(inSection: 0) {
            let prevIndexPath = IndexPath(row: currentIndexPath.row - 1, section: currentIndexPath.section)
            self.onboardingCollectionView.scrollToItem(at: prevIndexPath, at: .right, animated: true)
        }
        print("==berfore: \(Float(currentIndexPath?.row ?? 0))")
        progressIndex = Float(currentIndexPath?.row ?? 0)-1
        if (progressIndex <= 0.0) {
            progressIndex = 1.0
            print("==after: \(progressIndex)")
        } else if (progressIndex == 6) {
            progressIndex = Float(currentIndexPath?.row ?? 0)-3
        }
    }

    @objc
    private func startMotivooButtonDidTap() {
        questionArray["exerciseNote"] = choiceThreeButtonArray
        print(questionArray)
        requestPostExerciseAPI(
            type: questionArray["type"] as? String ?? "",
            age: questionArray["age"] as? Int ?? 0,
            isExercise: questionArray["isExercise"] != nil,
            exerciseType: questionArray["exerciseType"] as? String ?? "",
            exerciseCount: questionArray["exerciseCount"] as? String ?? "",
            exerciseTime: questionArray["exerciseTime"] as? String ?? "",
            exerciseNote: questionArray["exerciseNote"] as? [String] ?? []
        )
    }
}

extension OnboardingViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
                                     UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Size.width, height: Size.height-70)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("=====index: \(indexPath.row)")
        if indexPath.row == 1 {
            // indexPath.row가 1일 경우 OnboardingView2Cell을 반환
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingView2Cell.cellIdentifier, for: indexPath) as! OnboardingView2Cell
            cell.yesButton.addTarget(self, action: #selector(selectButtonDidTap2), for: .touchUpInside)
            cell.noButton.addTarget(self, action: #selector(selectButtonDidTap2), for: .touchUpInside)
            //self.onboardingProgressView.setProgress(0.3, animated: true)
            // 필요한 설정을 추가합니다.
            return cell
        } else if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingView3Cell.identifier, for: indexPath) as! OnboardingView3Cell
            cell.highButton.addTarget(self, action: #selector(selectButtonDidTap3), for: .touchUpInside)
            cell.mediumButton.addTarget(self, action: #selector(selectButtonDidTap3), for: .touchUpInside)
            cell.lowButton.addTarget(self, action: #selector(selectButtonDidTap3), for: .touchUpInside)
            //self.onboardingProgressView.setProgress(0.5, animated: true)
            return cell
        } else if indexPath.row == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingView4Cell.identifier, for: indexPath) as! OnboardingView4Cell
            cell.day1Button.addTarget(self, action: #selector(selectButtonDidTap4), for: .touchUpInside)
            cell.day2Button.addTarget(self, action: #selector(selectButtonDidTap4), for: .touchUpInside)
            cell.day3Button.addTarget(self, action: #selector(selectButtonDidTap4), for: .touchUpInside)
            cell.day5Button.addTarget(self, action: #selector(selectButtonDidTap4), for: .touchUpInside)
            //self.onboardingProgressView.setProgress(0.7, animated: true)
            return cell
        } else if indexPath.row == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingView5Cell.identifier, for: indexPath) as! OnboardingView5Cell
            cell.minutes30Button.addTarget(self, action: #selector(selectButtonDidTap5), for: .touchUpInside)
            cell.oneHourButton.addTarget(self, action: #selector(selectButtonDidTap5), for: .touchUpInside)
            cell.twoHourButton.addTarget(self, action: #selector(selectButtonDidTap5), for: .touchUpInside)
            cell.twoHoueOverButton.addTarget(self, action: #selector(selectButtonDidTap5), for: .touchUpInside)
            //self.onboardingProgressView.setProgress(0.8, animated: true)
            return cell
        } else if indexPath.row == 5 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingView6Cell.identifier, for: indexPath) as! OnboardingView6Cell
            cell.neckButton.addTarget(self, action: #selector(choiceMaxThreeButtonDidTap), for: .touchUpInside)
            cell.shoulderButton.addTarget(self, action: #selector(choiceMaxThreeButtonDidTap), for: .touchUpInside)
            cell.waistButton.addTarget(self, action: #selector(choiceMaxThreeButtonDidTap), for: .touchUpInside)
            cell.wristButton.addTarget(self, action: #selector(choiceMaxThreeButtonDidTap), for: .touchUpInside)
            cell.ankleButton.addTarget(self, action: #selector(choiceMaxThreeButtonDidTap), for: .touchUpInside)
            cell.kneeButton.addTarget(self, action: #selector(choiceMaxThreeButtonDidTap), for: .touchUpInside)
            cell.startMotivooButton.addTarget(self, action: #selector(startMotivooButtonDidTap), for: .touchUpInside)
            //onboardingProgressView.setProgress(1.0, animated: true)
            let cellInfo = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingView1Cell.identifier, for: indexPath) as! OnboardingView1Cell
            if (!cellInfo.childButton.isSelected) { // 자식 버튼 클릭
                questionArray["type"] = "자녀"
            } else {
                questionArray["type"] = "부모"
            }
            questionArray["age"] = cellInfo.ageInfo
            return cell
        } else {
            // OnboardingView1Cell을 반환
            self.customBackButton.addTarget(self, action: #selector(backViewController), for: .touchUpInside)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingView1Cell.identifier, for: indexPath) as! OnboardingView1Cell
            cell.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
            return cell
        }
    }
}

extension OnboardingViewController {
    func requestPostExerciseAPI(type: String, age: Int, isExercise: Bool, exerciseType: String, exerciseCount: String,
                                exerciseTime: String, exerciseNote: [String]) {
        let param = OnboardingExerciseRequest(type: type, age: age, isExercise: isExercise, exerciseType: exerciseType, exerciseCount: exerciseCount, exerciseTime: exerciseTime, exerciseNote: exerciseNote)
        OnboardingAPI.shared.postExercise(param: param) { result in
            guard let result = self.validateResult(result) as? OnboardingExerciseResponse else { return }
            // UserDefault에 inviteCode 저장
            UserDefaultManager.shared.saveInviteCode(inviteCode: result.inviteCode ?? "")
            let isMatched: Bool = UserDefaultManager.shared.getUserMatcehd()
            if isMatched {
                // 온보딩을 이전에 매칭이 완료된 경우
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                guard let delegate = sceneDelegate else {
                    print("sceneDelegate가 할당 Error")
                    return
                }
                let rootViewController = UINavigationController(rootViewController: MotivooTabBarController())
                delegate.window?.rootViewController = rootViewController
            } else {
                let invitationViewController = InvitationViewController()
                self.navigationController?.pushViewController(invitationViewController, animated: true)
            }
        }
    }
}
