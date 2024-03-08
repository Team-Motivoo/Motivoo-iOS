//
//  HomeAPI.swift
//  Motivoo-iOS
//
//  Created by 박윤빈 on 1/17/24.
//

import UIKit

import Moya

final class HomeAPI: BaseAPI {
    static let shared =  HomeAPI()
    private var homeProvider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
    private override init() {}
}

extension HomeAPI{
    public func patchHome(param: HomeRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.patchHome(param: param)) { (result) in
            self.disposeNetwork(
                result,
                dataModel: HomeIntroResponse.self,
                completion: completion
            )
        }
    }
    
    public func postMission(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.postMission) { (result) in
            self.disposeNetwork(
                result,
                dataModel: HomeMissionsResponse.self,
                completion: completion
            )
        }
    }
    
    public func postMissionChoice(param: HomeChoiceMissionRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.postMissionChoice(param: param)) { (result) in
            self.disposeNetwork(
                result,
                dataModel: BlankDataResponse.self,
                completion: completion
            )
        }
    }
    
    public func patchMissionImage(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getMissionImage) { (result) in
            self.disposeNetwork(
                result,
                dataModel: HomeMissionCheckResponse.self,
                completion: completion
            )
        }
    }
    
    public func putAtPreSignedURL(url: String, image: UIImage, completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.putImageWithPreSignedURL(url: url, image: image)) { (result) in
            self.disposeNetwork(
                result,
                dataModel: BlankDataResponse.self,
                completion: completion
            )
        }
    }
    
    public func postMateGoalStep(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.postMateGoalStep) { (result) in
            self.disposeNetwork(
                result,
                dataModel: HomeMateGoalStepResponse.self,
                completion: completion
            )
        }
    }
    
    public func patchMissionImage(fileName: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.patchMissionImage(fileName: fileName)) { (result) in
            self.disposeNetwork(result,
                                dataModel: BlankDataResponse.self,
                                completion: completion)
            
        }
    }
}
