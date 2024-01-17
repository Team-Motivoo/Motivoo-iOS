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
    
    private var db: DatabaseReference!
    private var timer: Timer? = nil
    
    var pedoMeter = CMPedometer()
    var uid: Int?
    var mid: Int?
    
    var stepCountDataCompletion: ((StepCountData) -> Void)?
    var mateStep: Int = 0 {
        didSet {
            //새로 업데이트된 값이 다를때만, 값 증가시켜주기
            if mateStep != stepCountData.mate {
                self.stepCountData.mate = mateStep
                self.updateStepCount(step: mateStep)
            }
        }
    }
    var tempChild: Int = 0 {
        didSet {
            if tempChild != stepCountData.user {
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
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        db.removeAllObservers()
        db = nil
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
                    print(self.tempChild)
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
        
        //한번만 쿼리 리스너 달아두면, 지속적으로 받아짐
        //여기서 collecion의 motivoo-test 는 안바뀌겠지만,,
        //"child1parent1" 는 사용자에 따라서 뭐 다르게 해줘도 되겠지?
        //중요한건 저 리스터 해제 안시켜주면 난리나니까, 앱 종료할때, 혹은 더이상 필요없을때 리스너 해제 잘 시켜줘
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
        self.db.child("Users/\(uid)").setValue(self.stepCountData.user)
    }
}
