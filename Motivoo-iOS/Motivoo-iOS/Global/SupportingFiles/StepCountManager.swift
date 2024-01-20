//
//  HealthKitManager.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/16/24.
//

import Foundation
import CoreMotion

import UIKit

import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseDatabaseInternal

struct StepCountData {
    var mate: Int = 0
    var user: Int = 0
}

final class StepCountManager {
    
    // MARK: - Properties
    
    static let shared = StepCountManager()
    
    var db: DatabaseReference!
    private var timer: Timer? = nil
    var isStepCountStarted = false
    var pedoMeter = CMPedometer()
    var uid: Int?
    var mid: Int?
    
    var stepCountDataCompletion: ((StepCountData) -> Void)?
    var mateStep: Int = 0 {
        didSet {
            //새로 업데이트된 값이 다를때만, 값 증가시켜주기
            if mateStep > stepCountData.mate {
                self.stepCountData.mate = mateStep
                self.updateStepCount(step: mateStep)
            }
        }
    }
    var tempChild: Int = 0 {
        didSet {
            if tempChild > stepCountData.user {
                self.stepCountData.user = tempChild
                self.updateStepCount(step: tempChild)
            }
        }
    }
    var stepCountData = StepCountData() {
        didSet {
            guard let stepCountDataCompletion else {return}
            stepCountDataCompletion(stepCountData)
        }
    }
    
    // MARK: - inits
    
    private init() {
        db = Database.database().reference()
        self.getStepCount()
    }
    
    deinit {
        db.removeAllObservers()
    }
    
    // MARK: - Custom Functions
    
    private func startTimer() {
        guard self.timer == nil else { return }
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3,
                                              target: self,
                                              selector: #selector(self.runLoop),
                                              userInfo: nil,
                                              repeats: true)
        }
        print("타이머 시작")
        isStepCountStarted = true
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        db.removeAllObservers()
        db = nil
        isStepCountStarted = false
        print("타이머 멈춤")
    }
    
    @objc private func runLoop() {
        self.getHealth()
        self.getStepCount()
    }
    
    func getHealth() {
        let now = Date()
        guard let todayStartDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: now) else {
            return
        }
        
        pedoMeter.queryPedometerData(from: todayStartDate, to: now) { data, error in
            if let error {
                print("CoreMotionService.queryPedometerData Error: \(error)")
                return
            }
            
            if let steps = data?.numberOfSteps {
                self.tempChild = Int(truncating: steps)

                DispatchQueue.main.async {
                    print("\n🧡🧡")
                    print("\(self.tempChild)\n")
                }
            }
        }
    }
    
    func startCheckStepCount() {
        self.startTimer()
    }
    
    func stopCheckStepCount() {
        self.stopTimer()
    }
    
    func getStepCount() {
        
        /// uid와 mid 들어왔을 때만돌아가도록
        guard let uid else { return }
        guard let mid else { return }
        db.child("Users/\(uid)").getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                print("허허 에러네요")
                return
            }
            self.stepCountData.user = snapshot?.value as? Int ?? 0
        })
        
        db.child("Users/\(mid)").getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                print("허허 에러네요")
                return
            }
            self.stepCountData.mate = snapshot?.value as? Int ?? 0
        })
    }
    
    //    걸음수가 바꼇을때 값 업데이트 해주는 부분
    func updateStepCount(step: Int) {
        guard let uid else { return }
            self.db.child("Users/\(uid)").setValue(self.stepCountData.user)
    }
}
