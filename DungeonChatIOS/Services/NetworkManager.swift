//
//  NetworkManager.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/19.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

import Foundation
import Alamofire
import Combine

enum NetworkManager {
    
    private static var session: Session {
        Session.default
    }
    
//    private static func dataRequest<Parameters: Encodable>(
//        _ url: URL,
//        method: HTTPMethod,
//        parameters: Parameters? = nil,
//        encoder: ParameterEncoder,
//        headers: HTTPHeaders? = nil,
//        interceptor: RequestInterceptor? = nil,
//        dispatchQueue: DispatchQueue = .global(qos: .default)
//    ) -> Future<Data, Error> {
//        return Future<Data, Error> { promise in
//            session.request(
//                url,
//                method: method,
//                parameters: parameters,
//                encoder: encoder,
//                headers: headers,
//                interceptor: interceptor
//            ).response (queue: dispatchQueue) { dataResponse in
//                if let data = dataResponse.data {
//                    promise(.success(data))
//                } else if let error = dataResponse.error {
//                    promise(.failure(error))
//                } else {
//                    promise(.failure(DungeonError.api()))
//                }
//            }
//        }
//    }
    
    private static func dataRequest<Parameters: Encodable>(
        _ url: URL,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoder: ParameterEncoder,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil
    ) -> Future<DataRequest, Error> {
        return Future<DataRequest, Error> { promise in
            promise(.success(session.request(
                url,
                method: method,
                parameters: parameters,
                encoder: encoder,
                headers: headers,
                interceptor: interceptor
            )))
        }
    }
    
    private static func request<Parameters: Encodable>(
        _ url: URL,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoder: ParameterEncoder,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        dispatchQueue: DispatchQueue = .global(qos: .default)
    ) -> Future<Decodable, Error> {
        return dataRequest(
            url,
            method: method,
            parameters: parameters,
            encoder: encoder,
            headers: headers,
            interceptor: interceptor
        ).flatMap { dataResponse -> Future<Decodable, Error> in
            
            if let data = dataResponse.data {
                promise(.success(data))
            } else if let error = dataResponse.error {
                promise(.failure(error))
            } else {
                promise(.failure(DungeonError.api()))
            }
        }
    }
    
    static func asdads() {
        let request = URLRequest(url: <#T##URLConvertible#>, method: <#T##HTTPMethod#>, headers: <#T##HTTPHeaders?#>)
        URLSession.shared.dataTaskPublisher(for: <#T##URLRequest#>)
    }
}
