//
//  NetworkManager.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/19.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

import Foundation
import Combine

fileprivate enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

fileprivate struct Response<T> {
    let value: T
    let response: URLResponse
}

enum NetworkManager {
    
    private static func request<Parameters: Encodable, T: Decodable>(
        url: URL,
        method: HTTPMethod,
        parameters: Parameters?,
        encoder: JSONEncoder,
        decoder: JSONDecoder,
        queue: DispatchQueue
    ) -> AnyPublisher<Response<T>, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let jsonData = try? encoder.encode(parameters) {
            request.httpBody = jsonData
        } else if parameters != nil {
            NSLog("Failed to encode HTTPBody parameters:", parameters.debugDescription)
        }
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
    
    private static func request<Parameters: Encodable, Result: Decodable>(
        _ url: URL,
        method: HTTPMethod,
        parameters: Parameters?,
        encoder: JSONEncoder,
        decoder: JSONDecoder,
        queue: DispatchQueue
    ) -> AnyPublisher<Result, Error> {
        
        return request(url: url, method: method, parameters: parameters, encoder: encoder, decoder: decoder, queue: queue)
            .tryMap { (response: Response<Result>) -> Result in
                if let httpResponse = response.response as? HTTPURLResponse,
                    !(200..<300).contains(httpResponse.statusCode) {
                    throw DungeonError.api(code: httpResponse.statusCode)
                }
                return response.value
            }
            .eraseToAnyPublisher()
    }
}
