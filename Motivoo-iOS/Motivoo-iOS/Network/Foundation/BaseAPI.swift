//
//  BaseAPI.swift
//  Motivoo-iOS
//
//  Created by 이조은 on 1/15/24.
//

import Foundation

import Moya

class BaseAPI{
    public func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<T>.self, from: data)
        else {
            print("디코딩이 안된다. 명세서 다시 봐라. 👀")
            return .pathErr
        }

        switch statusCode {
        case 200..<205:
            guard decodedData.data != nil else {
                print("⛔️ \(self)에서 디코딩 오류가 발생했습니다 ⛔️")
                return .decodedErr
            }
            print("⭐️ 모티뿡 💨 디코딩이 성공했습니다 ⭐️")
            return .success(decodedData.data as Any)
        case 400..<500:
            return .requestErr(decodedData.message ?? "요청에러")
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }

    // fetch 같은 것들은 data 응답이 따로 없기 때문에 여기서 처리
    private func judgeSimpleResponseStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(SimpleResponse.self, from: data)
        else {
            print("⛔️ \(self)에서 디코딩 오류가 발생했습니다 ⛔️")
            return .decodedErr
        }

        switch statusCode {
        case 200..<205:
            return .success(decodedData)
        case 406:
            return .authorizationFail((decodedData.message, decodedData.code))
        case 400..<500:
            return .requestErr(decodedData.message ?? "요청에러")
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }


    public func disposeNetwork<T: Codable>(_ result: Result<Response, MoyaError>,
                                           dataModel: T.Type,
                                           completion: @escaping (NetworkResult<Any>) -> Void) {
        print("📍\(#function) 에서 result \(result)")
        switch result{
        case .success(let response):
            let statusCode = response.statusCode
            let data = response.data

            if dataModel != BlankDataResponse.self { // BlankDataResponse <- 디코딩할게 없을때 사용
                let networkResult = self.judgeStatus(by: statusCode, data, dataModel.self)
                completion(networkResult)
            } else {  // 400,500같은 에러에는 data가 없기떄문에 여기서 한번 걸러줌
                let networkResult = self.judgeSimpleResponseStatus(by: statusCode, data)
                completion(networkResult)
            }

        case .failure(let err):
            print("[BaseAPI - disposeNetwork]/ndisposeNeretry에도 실패한것 같습니다.")
            print(err)
            completion(.authorizationFail("⚠️인증오류입니다뿡뿡뿡💨"))
        }
    }
}
