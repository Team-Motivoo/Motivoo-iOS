//
//  OnboardingAPI.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/16/24.
//

import Foundation

import Moya

final class OnboardingAPI: BaseAPI {
    static let shared = OnboardingAPI()
    private var onboardingProvider = MoyaProvider<OnboardingService>(plugins: [MoyaLoggingPlugin()])
    private override init() {}
}

extension OnboardingAPI {
    public func postLogin(param: OnboardingLoginRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.postLogin(param: param)) { (result) in
            self.disposeNetwork(result,
                                dataModel: OnboardingLoginResponse.self,
                                completion: completion
            )
        }
    }
    public func postExercise(param: OnboardingExerciseRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.postExercise(param: param)) { (result) in
            self.disposeNetwork(result,
                                dataModel: OnboardingExerciseResponse.self,
                                completion: completion
            )
        }
    }
    public func getExercise(completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.getExercise) { (result) in
            self.disposeNetwork(result,
                                dataModel: UserExerciseResponse.self,
                                completion: completion
            )
        }
    }
    public func patchInviteCode(param: InviteCodeRequest , completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.patchInviteCode(param: param)) { (result) in
            self.disposeNetwork(result,
                                dataModel: InviteCodeResponse.self,
                                completion: completion
            )
        }
    }
    public func getMatchingCheck(completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.getMatchingCheck) { (result) in
            self.disposeNetwork(result,
                                dataModel: InviteCodeResponse.self,
                                completion: completion
            )
        }
    }
}
