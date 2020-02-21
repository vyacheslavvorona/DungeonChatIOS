//
//  APIRoutes.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/20.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

import Foundation
import DungeonChatCore

enum APIRoutes {
    
    case register
    case login
    
    private static var baseURL: String {
        "http://localhost:8080"
    }
    
    private var urlString: String {
        switch self {
        case .register:
            return APIRoutes.baseURL + DungeonRoutes.User.userRegistration
        case .login:
            return APIRoutes.baseURL + DungeonRoutes.User.userLogin
        }
    }
    
    var url: URL {
        guard let url = URL(string: urlString) else {
            fatalError("Unable to compose API url")
        }
        return url
    }
}
