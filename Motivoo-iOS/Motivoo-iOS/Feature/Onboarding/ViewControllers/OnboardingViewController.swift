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
    lazy var selectButtonName3Second: String = ""
    lazy var selectButtonName4: String = ""
    lazy var selectButtonName5: String = ""

    lazy var questionArray: [String: Any] = ["type": "", "age": 0, "isExercise": true,
                                             "exerciseType":"", "exerciseCount":"", "exerciseTime":"", "exerciseNote":""]

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
        collectionView.register(OnboardingView3SecondCell.self,
                                forCellWithReuseIdentifier: OnboardingView3SecondCell.identifier)
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

        // 네비게이션 스택에서 온보딩VC 제거하기
        if let navigationController = self.navigationController {
            //print("삭제삭제삭제")
            var navigationArray = navigationController.viewControllers // 현재 네비게이션 스택을 가져옵니다.
            navigationArray.remove(at: navigationArray.count - 2) // 두 번째로 마지막인 FirstVC를 제거합니다.
            self.navigationController?.viewControllers = navigationArray // 수정된 스택을 다시 설정합니다.
        }
        self.customBackButton.removeTarget(self, action: #selector(prevButtonDidTap), for: .touchUpInside)
        self.customBackButton.addTarget(self, action: #selector(backViewController), for: .touchUpInside)
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
            let reloadIndexPath = IndexPath(item: 2, section: 0)
            onboardingCollectionView.reloadItems(at: [reloadIndexPath])
            nextButtonDidTap()
        } else {
            sender.isSelected = true
            selectButtonName2 = ""
            questionArray["isExercise"] = nil
        }
        print("buttonTap: \(selectButtonName2)")
    }

    @objc
    private func selectButtonDidTap3(_ sender: UIButton) {
        if (sender.isSelected) {
            if (selectButtonName3 == "") {
                // 버튼 선택
                sender.isSelected = false
                selectButtonName3 = sender.accessibilityIdentifier ?? "Unknown"
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
                    selectButtonName3 = sender.accessibilityIdentifier ?? "Unknown"
                }
            }
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
    private func selectButtonDidTap3Second(_ sender: UIButton) {
        if (sender.isSelected) {
            if (selectButtonName3Second == "") {
                // 버튼 선택
                sender.isSelected = false
                selectButtonName3Second = sender.accessibilityIdentifier ?? "Unknown"
            } else {
                let indexPath = IndexPath(row: 2, section: 0)
                if let cell = self.onboardingCollectionView.cellForItem(at: indexPath) as? OnboardingView3SecondCell {
                    if (selectButtonName3Second == "high2") { // 선택 되었던걸 true로 선택 취소
                        cell.highButton.isSelected = true
                    } else if (selectButtonName3Second == "medium2") {
                        cell.mediumButton.isSelected = true
                    }
                    else {
                        cell.lowButton.isSelected = true
                    }
                    sender.isSelected = false
                    selectButtonName3Second = sender.accessibilityIdentifier ?? "Unknown"
                }
            }
            if selectButtonName3Second == "high2" {
                questionArray["exerciseType"] = TextLiterals.Onboarding.Q4.highTitle
            } else if selectButtonName3Second == "medium2" {
                questionArray["exerciseType"] = TextLiterals.Onboarding.Q4.middleTitle
            } else {
                questionArray["exerciseType"] = TextLiterals.Onboarding.Q4.lowTitle
            }
            nextButtonDidTap()
        } else {
            sender.isSelected = true
            selectButtonName3Second = ""
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
            }
        } else {
            sender.isSelected = true
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
    }

    @objc
    private func prevButtonDidTap() {
        // print("indexpath - 1")
        print("=== prevButtonDidTap ===")
        //print("prevButtonDidTapprevButtonDidTapprevButtonDidTapprevButtonDidTap")
        let currentIndexPath = self.onboardingCollectionView.indexPathsForVisibleItems.first
        if let currentIndexPath = currentIndexPath, currentIndexPath.row - 1 < self.onboardingCollectionView.numberOfItems(inSection: 0) {
            let prevIndexPath = IndexPath(row: currentIndexPath.row - 1, section: currentIndexPath.section)
            self.onboardingCollectionView.scrollToItem(at: prevIndexPath, at: .right, animated: true)
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


    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // 셀이 화면에 표시되기 직전에 호출되는 코드
        // print("Cell at \(indexPath.row/6) will display")
        let cellIndex = Float(indexPath.row + 1)
        onboardingProgressView.setProgress(cellIndex/6, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // print("=====index: \(indexPath.row)")
        if indexPath.row == 1 {
            // indexPath.row가 1일 경우 OnboardingView2Cell을 반환
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingView2Cell.cellIdentifier, for: indexPath) as! OnboardingView2Cell
            cell.yesButton.addTarget(self, action: #selector(selectButtonDidTap2), for: .touchUpInside)
            cell.noButton.addTarget(self, action: #selector(selectButtonDidTap2), for: .touchUpInside)
            // 필요한 설정을 추가합니다.
            return cell
        } else if indexPath.row == 2 {
            print("=====selectButtonName2: \(selectButtonName2)")
            if (selectButtonName2 == "yes") {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingView3Cell.identifier, for: indexPath) as! OnboardingView3Cell
                cell.highButton.addTarget(self, action: #selector(selectButtonDidTap3), for: .touchUpInside)
                cell.mediumButton.addTarget(self, action: #selector(selectButtonDidTap3), for: .touchUpInside)
                cell.lowButton.addTarget(self, action: #selector(selectButtonDidTap3), for: .touchUpInside)
                // print("yesyesyesyesyesyesyesyesyesyes")
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingView3SecondCell.identifier, for: indexPath) as! OnboardingView3SecondCell
                cell.highButton.addTarget(self, action: #selector(selectButtonDidTap3Second), for: .touchUpInside)
                cell.mediumButton.addTarget(self, action: #selector(selectButtonDidTap3Second), for: .touchUpInside)
                cell.lowButton.addTarget(self, action: #selector(selectButtonDidTap3Second), for: .touchUpInside)
                // print("nononononononononono")
                return cell
            }
        } else if indexPath.row == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingView4Cell.identifier, for: indexPath) as! OnboardingView4Cell
            if (selectButtonName2 == "yes") {
                cell.question4Title.text = TextLiterals.Onboarding.Q3.howManyExercise
            } else {
                cell.question4Title.text = TextLiterals.Onboarding.Q4.howManyExercise
            }
            cell.day1Button.addTarget(self, action: #selector(selectButtonDidTap4), for: .touchUpInside)
            cell.day2Button.addTarget(self, action: #selector(selectButtonDidTap4), for: .touchUpInside)
            cell.day3Button.addTarget(self, action: #selector(selectButtonDidTap4), for: .touchUpInside)
            cell.day5Button.addTarget(self, action: #selector(selectButtonDidTap4), for: .touchUpInside)
            return cell
        } else if indexPath.row == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingView5Cell.identifier, for: indexPath) as! OnboardingView5Cell
            if (selectButtonName2 == "yes") {
                cell.question5Title.text = TextLiterals.Onboarding.Q3.howLongExercise
            } else {
                cell.question5Title.text = TextLiterals.Onboarding.Q4.howLongExercise
            }
            cell.minutes30Button.addTarget(self, action: #selector(selectButtonDidTap5), for: .touchUpInside)
            cell.oneHourButton.addTarget(self, action: #selector(selectButtonDidTap5), for: .touchUpInside)
            cell.twoHourButton.addTarget(self, action: #selector(selectButtonDidTap5), for: .touchUpInside)
            cell.twoHoueOverButton.addTarget(self, action: #selector(selectButtonDidTap5), for: .touchUpInside)
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
            // 온보딩 완료 저장
            UserDefaultManager.shared.saveFinishedOnboarding(finished: true)
            // 모티부 시작하기 페이지로 이동
            let startViewController = StartViewController()
            self.navigationController?.pushViewController(startViewController, animated: true)
        }
    }
}
