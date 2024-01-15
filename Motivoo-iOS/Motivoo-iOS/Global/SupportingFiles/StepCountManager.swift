//
//  HealthKitManager.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/16/24.
//

import HealthKit
import UIKit

final class HealthKitManager {
    
    static let shared = HealthKitManager()
    
    private init(){}
    
    var step: Double?
    var healthStore = HKHealthStore()
    var read = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
    var share = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
    
    func checkStepCountAuthorization() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        switch healthStore.authorizationStatus(for: stepType) {
        case .notDetermined:
            print("권한 상태: 결정되지 않음")
        case .sharingDenied:
            print("권한 상태: 사용자가 거부함")
        case .sharingAuthorized:
            print("권한 상태: 사용자가 허용함")
        @unknown default:
            print("권한 상태: 알 수없음")
        }
    }
    
    func getStepCount() {
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: stepQuantityType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                print("Failed to fetch steps")
                return
            }
            
            self.step = sum.doubleValue(for: HKUnit.count())
            print("오늘 걸음 수:\(self.step)")
        }
        healthStore.execute(query)
    }
}

import Foundation
import CoreMotion

import UIKit
//import FirebaseCore
//import FirebaseFirestore
//import FirebaseFirestoreSwift

struct StepCountData {
    var parent: Int = 0
    var child: Int = 0
}

final class StepCountManager {
    
    // MARK: - Properties
    
    static let shared = StepCountManager()
//    private var db: Firestore!
    private var timer: Timer? = nil
    var pedoMeter = CMPedometer()
    var isAuthAllowed: Bool = false
    var healthStore = HKHealthStore()
    var read = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
    var share = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
    
//    private var snapShotListener: ListenerRegistration?
    
    var stepCountDataCompletion: ((StepCountData) -> Void)?
    
    var tempParent: Int = 0 {
        didSet {
            //새로 업데이트된 값이 다를때만, 값 증가시켜주기
            if tempParent != stepCountData.parent {
                self.stepCountData.parent = tempParent
//                self.updateStepCount(step: tempParent)
            }
        }
    }
    var tempChild: Int = 0 {
        didSet {
            if tempChild != stepCountData.child {
                self.stepCountData.child = tempChild
//                self.updateStepCount(step: tempChild)
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
//        db = Firestore.firestore()
//        self.getStepCount()
    }
    
    deinit {
//        snapShotListener?.remove()
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
    
    @objc private func runLoop() {
        //        self.snapShotListener?.remove()
        //        self.snapShotListener = nil
        self.getHealth()
        //        self.getStepCount()
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
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        print("타이머 멈춤")
    }
    
    func startCheckStepCount() {
        self.startTimer()
    }
    
    func stopCheckStepCount() {
        self.stopTimer()
    }
    
    
//    func getStepCount() {
//        //한번만 쿼리 리스너 달아두면, 지속적으로 받아짐
//        //여기서 collecion의 motivoo-test 는 안바뀌겠지만,,
//        //"child1parent1" 는 사용자에 따라서 뭐 다르게 해줘도 되겠지?
//        //중요한건 저 리스터 해제 안시켜주면 난리나니까, 앱 종료할때, 혹은 더이상 필요없을때 리스너 해제 잘 시켜줘
//        self.snapShotListener = db.collection("motivoo-test").document("child2parent2")
//            .addSnapshotListener { documentSnapshot, error in
//                guard let document = documentSnapshot else {
//                    print("Error fetching document: \(error!)")
//                    return
//                }
//                guard let data = document.data() else {
//                    print("Document data was empty.")
//                    return
//                }
//                if let parentStepCount = data["parentCount"] as? Int,
//                   let childStepCount = data["childCount"] as? Int {
//                    self.stepCountData.parent = parentStepCount
//                    self.stepCountData.child = childStepCount
//                }
//                print("Current data: \(data)")
//            }
//    }
    
    //걸음수가 바꼇을때 값 업데이트 해주는 부분
//    func updateStepCount(step: Int) {
//        db.collection("motivoo-test").document("child2parent2")
//            .addSnapshotListener { documentSnapshot, error in
//                guard let document = documentSnapshot else {
//                    print("Error fetching document: \(error!)")
//                    return
//                }
//                document.reference.updateData(["childCount": self.stepCountData.child,
//                                               "parentCount": self.stepCountData.parent])
//            }
//    }
}

