//
//  OverviewAPI.swift
//  Motivoo-iOS
//
//  Created by Hyori Choi on 1/17/24.
//

import Foundation

import Moya

final class OverviewAPI: BaseAPI {
    static let shared = OverviewAPI()
    private var myProvider = MoyaProvider<OverviewService>(plugins: [MoyaLoggingPlugin()])
    private override init() {}
}

extension OverviewAPI{
    public func getMission(completion: @escaping (NetworkResult<Any>) -> Void) {
        myProvider.request(.getMission) { (result) in
            self.disposeNetwork(
                result,
                dataModel: OverViewResponse.self,
                completion: completion
            )
        }
    }
}

