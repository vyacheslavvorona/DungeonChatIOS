//
//  NetworkManager.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/19.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

import Foundation
import Combine
import DungeonChatCore

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

fileprivate struct Empty: Encodable {
   static let instance: Empty? = nil
}

// MARK: - NetworkManager
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
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        if let jsonData = try? encoder.encode(parameters) {
            request.httpBody = jsonData
        } else if parameters != nil {
            NSLog("Failed to encode HTTPBody parameters:", parameters.debugDescription)
        }
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                if let httpResponse = result.response as? HTTPURLResponse,
                    !(200..<300).contains(httpResponse.statusCode) {
                    let middlewareError = try? decoder.decode(ErrorMiddlewareContent.self, from: result.data)
                    throw DungeonError.api(code: httpResponse.statusCode, message: middlewareError?.reason ?? "Unknown reason")
                } else if let value = try? decoder.decode(T.self, from: result.data) {
                    return Response(value: value, response: result.response)
                }
                throw DungeonError.coding(message: "Unable to decode response")
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
            .map { (response: Response<Result>) -> Result in response.value }
            .eraseToAnyPublisher()
    }
}

// MARK: - REST boilerplate

extension NetworkManager {
    
    static func get<Parameters: Encodable, Result: Decodable>(
        _ api: APIRoutes,
        parameters: Parameters? = nil,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder.iso8601,
        queue: DispatchQueue = DispatchQueue.global(qos: .default)
    ) -> AnyPublisher<Result, Error> {
        return request(api.url, method: .get, parameters: parameters, encoder: encoder, decoder: decoder, queue: queue)
    }
    
    static func post<Parameters: Encodable, Result: Decodable>(
        _ api: APIRoutes,
        parameters: Parameters? = nil,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder.iso8601,
        queue: DispatchQueue = DispatchQueue.global(qos: .default)
    ) -> AnyPublisher<Result, Error> {
        return request(api.url, method: .post, parameters: parameters, encoder: encoder, decoder: decoder, queue: queue)
    }
    
    static func put<Parameters: Encodable, Result: Decodable>(
        _ api: APIRoutes,
        parameters: Parameters? = nil,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder.iso8601,
        queue: DispatchQueue = DispatchQueue.global(qos: .default)
    ) -> AnyPublisher<Result, Error> {
        return request(api.url, method: .put, parameters: parameters, encoder: encoder, decoder: decoder, queue: queue)
    }
    
    static func delete<Parameters: Encodable, Result: Decodable>(
        _ api: APIRoutes,
        parameters: Parameters? = nil,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder.iso8601,
        queue: DispatchQueue = DispatchQueue.global(qos: .default)
    ) -> AnyPublisher<Result, Error> {
        return request(api.url, method: .delete, parameters: parameters, encoder: encoder, decoder: decoder, queue: queue)
    }
}

// Without parameters argument
extension NetworkManager {
    
    static func get<Result: Decodable>(
        _ api: APIRoutes,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder.iso8601,
        queue: DispatchQueue = DispatchQueue.global(qos: .default)
    ) -> AnyPublisher<Result, Error> {
        return request(api.url, method: .get, parameters: Empty.instance, encoder: encoder, decoder: decoder, queue: queue)
    }
    
    static func post<Result: Decodable>(
        _ api: APIRoutes,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder.iso8601,
        queue: DispatchQueue = DispatchQueue.global(qos: .default)
    ) -> AnyPublisher<Result, Error> {
        return request(api.url, method: .post, parameters: Empty.instance, encoder: encoder, decoder: decoder, queue: queue)
    }
    
    static func put<Result: Decodable>(
        _ api: APIRoutes,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder.iso8601,
        queue: DispatchQueue = DispatchQueue.global(qos: .default)
    ) -> AnyPublisher<Result, Error> {
        return request(api.url, method: .put, parameters: Empty.instance, encoder: encoder, decoder: decoder, queue: queue)
    }
    
    static func delete<Result: Decodable>(
        _ api: APIRoutes,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder.iso8601,
        queue: DispatchQueue = DispatchQueue.global(qos: .default)
    ) -> AnyPublisher<Result, Error> {
        return request(api.url, method: .delete, parameters: Empty.instance, encoder: encoder, decoder: decoder, queue: queue)
    }
}
