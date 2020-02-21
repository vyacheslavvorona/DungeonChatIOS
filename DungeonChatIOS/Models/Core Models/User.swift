//
//  User.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/18.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

import DungeonChatCore
import Foundation
import Combine

class User: SharedUser {
    var id: Int?
    var email: String
    var firstName: String?
    var lastName: String?
    var username: String?
    var registrationDate: Date?
    
    init?(email: String) {
        guard Email(email) != nil else { return nil }
        self.email = email
    }
    
    init(email: Email) {
        self.email = email.stringValue
    }
}

// MARK: - API calls

extension User {
    
    static func register(with content: UserContent) -> AnyPublisher<UserContent, Error> {
        NetworkManager.post(.register, parameters: content)
    }
    
    static func login(with content: UserContent) -> AnyPublisher<AuthToken, Error> {
        NetworkManager.post(.login, parameters: content)
    }
}
