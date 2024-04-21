//
//  HomeViewController.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 2024/01/05.
//

/// 확인해야할 것
/// 목표걸음수 달성한 후, 서버에게 API 쏜 뒤, isStepCountCompleted가 true 들어올때까지의 시간차
/// 사진 인증 완료 후, isMissionCompleted가 true들어올때까지의 시간차
/// API 응답값으로의 의존을 줄이기

import UIKit

import SnapKit
import Then
import SafariServices

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    private var timer: Timer? = nil
    private var quest: String = String()
    private var goalStep: Int = 0 {
        didSet {
            // TODO: - 이거 oldValue == 0 판별식 왜 있는거임...?
            if oldValue == 0 {
                DispatchQueue.main.async {
                    self.homeView.homeCircularProgressView.setMyProgress(currentStep: self.tempUserStep,
                                                                         finalStep: self.goalStep ,
                                                                         withAnimation: true)
                }
            }
        }
    }
    private var mateGoalStep: Int = 0 {
        didSet {
            if mateGoalStep != 0 {
                isStepZero = false
            }
            
            if oldValue == 0 {
                self.homeView.homeCircularProgressView.setParentProgress(currentStep: self.tempMateStep,
                                                                         finalStep: self.mateGoalStep ,
                                                                         withAnimation: true)
            }
        }
    }
    private var isStepZero: Bool = true
    private var guideURL = String()
    /// 나중에 인증 완료 API 들어오면 바인딩
//    private var isMissionCompleted: Bool = false
    private var isMissionCompleted: Bool = false {
        didSet {
            print("미션 인증 이미지 완료 했는지 여부. 서버통신 하자마자 바뀌나요? -> \(isMissionCompleted)")
        }
    }
    private var isStepCountCompleted: Bool = false {
        didSet {
            if isStepCountCompleted {
                print("걸음수 달성 완료함!💦💦💦")
//                DispatchQueue.main.async {
//                    self.homeView.configureCheckButtonStyle(state: .completed)
//                }
            }
            
            if isStepCountCompleted && isMateStepCountCompleted {
                DispatchQueue.main.async {
                    self.homeView.homeCircularProgressView.configureProgressBar(state: .completed)
                }
            } else {
                DispatchQueue.main.async {
                    self.homeView.homeCircularProgressView.configureProgressBar(state: .unCompleted)
                }
            }
        }
    }
    private var isMateStepCountCompleted: Bool = false {
        didSet {
            if isStepCountCompleted && isMateStepCountCompleted {
                DispatchQueue.main.async {
                    self.homeView.homeCircularProgressView.configureProgressBar(state: .completed)
                }
            } else {
                DispatchQueue.main.async {
                    self.homeView.homeCircularProgressView.configureProgressBar(state: .unCompleted)
                }
            }
        }
    }
    private var tempUserStep: Int = 0 {
        didSet {
            if oldValue < tempUserStep {
                if tempUserStep >= goalStep {
                    isStepCountCompleted = true
                }
                DispatchQueue.main.async {
                    self.homeView.homeCircularProgressView.setMyProgress(currentStep: self.tempUserStep,
                                                                         finalStep: self.goalStep ,
                                                                         withAnimation: true)
                    self.homeView.homeStepCountView.myWalkCountLabel.text = "\(self.tempUserStep)"
                    
                    /// 나중에 미션 인증 여부 들어오면 이거 감싸서 미션 인증 된건 굳이 판단하지 않도록
                    self.judgeButtonStyle(goal: self.goalStep, now: self.tempUserStep)
                }
            }
        }
    }
    private var tempMateStep: Int = 0 {
        didSet {
            if oldValue < tempMateStep {
                if mateGoalStep > 0 && mateGoalStep <= tempMateStep {
                    self.isMateStepCountCompleted = true
                }
                DispatchQueue.main.async {
                    self.homeView.homeCircularProgressView.setParentProgress(currentStep: self.tempMateStep,
                                                                             finalStep: self.mateGoalStep,
                                                                             withAnimation: true)
                    self.homeView.homeStepCountView.parentWalkCountLabel.text = "\(self.tempMateStep)"
                }
            }
        }
    }
    private var firstMissionData = MissionChoiceList(missionID: Int(),
                                                     missionContent: String(),
                                                     missionIconURL: String())
    private var secondMissionData = MissionChoiceList(missionID: Int(),
                                                      missionContent: String(),
                                                      missionIconURL: String())
    
    // MARK: - UI Components
    
    private var homeView = HomeView()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !StepCountManager.shared.isStepCountStarted {
            StepCountManager.shared.startCheckStepCount()
        }
        configureStepCount()
        requestGetHome()
        
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: - 권한 허용 안되어있으면 Alert 띄우기
        print("=============HomeVCWillAppear==============")
        // 네트워크 통신
        configureMissionTapGesture()
        requestPostMission()
        requestGetHome()
    }
    
    // MARK: - Override Functions
    
    override func setUI() {
        self.view.backgroundColor = .gray100
    }
    
    override func setHierachy() {
        self.view.addSubview(homeView)
    }
    
    override func setLayout() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        homeView.checkMissionButton.addTarget(self, action: #selector(checkButtonDidTapped), for: .touchUpInside)
        homeView.guideButton.addTarget(self, action: #selector(guideButtonDidTapped), for: .touchUpInside)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
    }
    
    // MARK: - Custom Method
    
    private func configureMissionTapGesture() {
        let firstMissionViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(firstMissionViewDidTapped))
        let secondMissionViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(secondMissionViewDidTapped))
        
        homeView.firstMissionView.addGestureRecognizer(firstMissionViewTappedGesture)
        homeView.secondMissionView.addGestureRecognizer(secondMissionViewTappedGesture)
    }
    
    @objc
    private func firstMissionViewDidTapped() {
        if !homeView.isMissionSelected {
            requestPostMissionChoice(param: HomeChoiceMissionRequest(missionID: firstMissionData.missionID))
            homeView.pickMissionLabel.text = firstMissionData.missionContent
            homeView.dateLabel.text = "오늘의 운동"
        }
    }
    
    @objc
    private func secondMissionViewDidTapped() {
        if !homeView.isMissionSelected {
            requestPostMissionChoice(param: HomeChoiceMissionRequest(missionID: secondMissionData.missionID))
            homeView.pickMissionLabel.text = secondMissionData.missionContent
            homeView.dateLabel.text = "오늘의 운동"
        }
    }
    
    @objc
    private func guideButtonDidTapped() {
        if guideURL != "" {
            let notionURL = NSURL(string: guideURL)
            let notionSafariView: SFSafariViewController = SFSafariViewController(url: notionURL! as URL)
            self.present(notionSafariView, animated: true, completion: nil)
        } else {
            showMatchingLabel("운동방법 링크가 존재하지 않아요", withDuration: 0.5, delay: 2.0)
        }
    }
    
    private func configureStepCountView(user: Int, mate: Int) {
        homeView.homeStepCountView.configureView(myWalk: user,
                                                 parentWalk: mate)
    }
    
    @objc
    private func checkButtonDidTapped() {
        
        ///인증하기 버튼 활성화 됐을 때 터치이벤트
        let homeProveViewController = HomeProveViewController()
        
        /// BottomSheet의 PanGesture 제거
        let noopPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: nil)
        noopPanGestureRecognizer.cancelsTouchesInView = false
        homeProveViewController.view.addGestureRecognizer(noopPanGestureRecognizer)
        
        ///BottomSheet의 높이 조정
        if let proveSheet = homeProveViewController.sheetPresentationController {
            proveSheet.detents = [
                .custom { _ in
                    return 356.adjusted
                }
            ]
            proveSheet.preferredCornerRadius = 20
        }
        
        /// Main에서 고른 미션 text를 전달하는 closure
        homeProveViewController.missionHandler = { [weak self] in
            guard let self else { return }
            homeView.dimmView.isHidden = false
            homeProveViewController.mission = self.homeView.pickMissionLabel.text ?? String()
        }
        
        /// present 됐을 때 뒷배경을 더 어둡게 하기 위한 View 보이게 해주기
        /// 이때, closure를 사용하여 dismiss 됐을 때, 어둡게 보이는 View를 숨기기
        homeProveViewController.onDismissHandler = { [weak self] in
            guard let self else { return }
            self.homeView.dimmView.isHidden = true
        }
        homeProveViewController.bindQuest(content: self.quest)
        self.present(homeProveViewController, animated: true)
    }
    
    private func configureStepCount() {
        StepCountManager.shared.stepCountDataCompletion = { [weak self] newData in
            print("\n🚀🚀")
            print("내 걸음수: \(newData.user)\n")
            print("상대방 걸음수: \(newData.mate)\n")
            self?.tempUserStep = newData.user
            self?.tempMateStep = newData.mate
        }
    }
    
    ///비활성화 된 상태에서, 화면 밖으로 나가지 않고 즉시 걸음수 충족 및 인증 완료를 확인하기 위한 처리.
    ///화면으로부터 나간 후, 다시 들어왔을 때는 서버에서 isMissionCompleted 값을 준다.
    private func judgeButtonStyle(goal goalStep: Int, now currentStep: Int) {
        if goalStep > 0 && goalStep > currentStep {
            homeView.configureCheckButtonStyle(state: .unCompleted)
        } else { /// 목표 걸음수를 채웠을 때의 두 가지 경우.
            self.isStepCountCompleted = true
            if isMissionCompleted {
                homeView.configureCheckButtonStyle(state: .checkCompleted)
            } else {
                homeView.configureCheckButtonStyle(state: .completed)
            }
        }
    }
    
    func checkDataAndPerformAction(id: Int) {
        let childPath = "Users" // 여기에 확인하고자 하는 child의 경로를 설정합니다.

        StepCountManager.shared.db.child(childPath).getData(completion: { [weak self] error, snapshot in

            if let error = error {
                print("Error getting data \(error)")
            } else if ((snapshot?.exists()) != nil) {
                // 데이터가 존재하는 경우
                print("이미 존재하는 유저!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            } else {
                // 데이터가 존재하지 않는 경우
                // 새로운 child 등록 또는 기본값 설정
                StepCountManager.shared.db.child(childPath).setValue(["\(id)": 0])
            }
        })
    }
    
    func showMatchingLabel(_ message : String, withDuration: Double, delay: Double) {
        let toastLabel = UILabel()
        toastLabel.do {
            $0.textColor = .pink
            $0.font = .caption1
            $0.textAlignment = .center
            $0.text = message
            $0.alpha = 1.0
        }

        self.view.addSubview(toastLabel)

        toastLabel.snp.makeConstraints {
            $0.bottom.equalTo(homeView.homeStepCountView.snp.top).offset(-2.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(192.adjusted)
            $0.height.equalTo(44.adjusted)
        }

        UIView.animate(withDuration: withDuration, delay: delay, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    private func startTimer() {
        guard self.timer == nil else { return }
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3,
                                              target: self,
                                              selector: #selector(self.runLoop),
                                              userInfo: nil,
                                              repeats: true)
        }
        print("걸음수 타이머 시작")
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        print("걸음수 타이머 멈춤")
    }
    
    @objc private func runLoop() {
        if isStepZero {
            self.requestPostMateGoalStep()
        } else {
            self.stopTimer()
        }
    }
}

// MARK: - Network Functions

extension HomeViewController {
    private func requestGetHome() {
        HomeAPI.shared.getHome() { result in
            guard let result = self.validateResult(result) as? HomeIntroResponse else { return }
            print("requestGetHome!!!!!!!!!!!")
            /// StepCountManager에 uid와 mid를 매칭.
            /// uid와 mid가 있어야 파이어베이스에서 값을 읽어오고, 저장 할 수 있도록 로직을 구생했기 때문
            StepCountManager.shared.uid = result.userID
            StepCountManager.shared.mid = result.opponentUserID
            
            /// 이미 가입이 완료되어서 table이 등록 되어있는 유저라면, 다시 레코드를 추가해주면 안되므로
            /// uid로 데이터를 받아오는 요청을 한번 보낸 후, 에러가 난다면 table에 uid로 등록하도록 하는 함수
            self.checkDataAndPerformAction(id: result.userID)

            /// 서버한테서 오는 목표걸음 수 낮아지면 주석 해제
            self.goalStep = result.userGoalStepCount
            self.mateGoalStep = result.opponentUserGoalStepCount
            self.isStepCountCompleted = result.isStepCountCompleted
            self.isMissionCompleted = result.isMissionImgCompleted
            print("걸음수 달성했는지 안했는지 응답 들오네요! -> \(result.isStepCountCompleted)이거 맞나요?💦💦💦")

            if result.isMissionImgCompleted {
                self.homeView.configureCheckButtonStyle(state: .checkCompleted)
            } else if result.isStepCountCompleted {
                self.homeView.configureCheckButtonStyle(state: .completed)
                if self.isMateStepCountCompleted {
                    DispatchQueue.main.async {
                        self.homeView.homeCircularProgressView.configureProgressBar(state: .completed)
                    }
                }
            } else {
                self.homeView.configureCheckButtonStyle(state: .unCompleted)
            }

            if result.userType == "자녀" {
                self.homeView.homeStepCountView.parentWalkLabel.text = "부모님 걸음"

            } else if result.userType == "부모" {
                self.homeView.homeStepCountView.parentWalkLabel.text = "자녀 걸음"
            }
        }
    }
    
    private func requestPostMission() {
        HomeAPI.shared.postMission{ result in
            guard let result = self.validateResult(result) as? HomeMissionsResponse else { return }
            print("requestPostMission!!!!!!!!!!!")
            self.homeView.configureView(data: result)
            if result.missionChoiceList != nil {
                /// 미션을 고르자마자 뷰가 변함 -> 이 뷰에 대한 데이터 바인딩을 위해 VC에 받은 정보를 저장
                self.firstMissionData = result.missionChoiceList?[0] ?? MissionChoiceList(missionID: Int(),
                                                                                          missionContent: String(),
                                                                                          missionIconURL: String())
                self.secondMissionData = result.missionChoiceList?[1] ?? MissionChoiceList(missionID: Int(),
                                                                                           missionContent: String(),
                                                                                           missionIconURL: String())
            } else {
                self.homeView.dateLabel.text = "오늘의 운동"
                self.guideURL = result.todayMission?.missionDescription ?? ""
                self.quest = result.todayMission?.missionQuest ?? ""
                self.requestGetHome()
            }
        }
    }
    
    private func requestPostMissionChoice(param: HomeChoiceMissionRequest) {
        HomeAPI.shared.postMissionChoice(param: param) { result in
            guard let result = self.validateResult(result) as? SimpleResponse else { return }
            print("requestPostMissionChoice!!!!!!!!!!!")
            self.homeView.configureMissionSelectedView(isSelected: true)
            
            /// 미션 선택 직후, 걸음수 그래프가 바껴야 함.
            /// 그러려면, 내 목표걸음수와 상대방 목표 걸음수가 정상적으로 들어온 뒤, 프로그래스 바 세팅을 해주어야 함.
            /// 그래서 목표 걸음수가 들어오는 API인 requestGetHome을 한번 더 호출
            self.requestGetHome()
        }
    }
    
    private func requestPostMateGoalStep() {
        HomeAPI.shared.postMateGoalStep { result in
            guard let result = self.validateResult(result) as? HomeMateGoalStepResponse else { return }
            print("requestPostMateGoalStep!!!!!!!!!!!")
            self.mateGoalStep = result.opponentGoalStepCount
            
        }
    }
}
