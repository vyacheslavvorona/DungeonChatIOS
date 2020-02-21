//
//  AuthToken.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/21.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

import Foundation
import DungeonChatCore

struct AuthToken: SharedAuthToken {
    let token: String
    let userId: Int
    let authDate: Date
}

