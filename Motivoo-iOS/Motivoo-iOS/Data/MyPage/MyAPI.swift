//
//  MyAPI.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/16/24.
//

import Foundation

import Moya

final class MyAPI: BaseAPI {
    static let shared = MyAPI()
    private var myProvider = MoyaProvider<MyService>(plugins: [MoyaLoggingPlugin()])
    private override init() {}
}

extension MyAPI{
    public func getMyInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        myProvider.request(.getMyInfo) { (result) in
            self.disposeNetwork(
                result,
                dataModel: MyInfoUserResponse.self,
                completion: completion
            )
        }
    }
    public func getExerciseInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        myProvider.request(.getExerciseInfo) { (result) in
            self.disposeNetwork(
                result,
                dataModel: ExerciseInfoResponse.self,
                completion: completion
            )
        }
    }
    public func postLogout(completion: @escaping (NetworkResult<Any>) -> Void) {
        myProvider.request(.postLogout) { (result) in
            self.disposeNetwork(
                result,
                dataModel: BlankDataResponse.self,
                completion: completion
            )
        }
    }
    public func deleteLeave(completion: @escaping (NetworkResult<Any>) -> Void) {
        myProvider.request(.deleteLeave) { (result) in
            self.disposeNetwork(
                result,
                dataModel: BlankDataResponse.self,
                completion: completion
            )
        }
    }
}
