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
    
    case registerUser
    case login
    
    private static var baseURL: String {
        "http://localhost:8080"
    }
    
    private var urlString: String {
        switch self {
        case .registerUser:
            return APIRoutes.baseURL + DungeonRoutes.User.userRegistration
        case .login:
            return APIRoutes.baseURL + DungeonRoutes.User.userLogin
        }
    }
    
    var url: URL {
        URL(fileURLWithPath: urlString)
    }
}
