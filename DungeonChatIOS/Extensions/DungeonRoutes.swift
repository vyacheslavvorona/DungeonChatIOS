//
//  DungeonRoutes.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/20.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

import DungeonChatCore

extension DungeonRoutes.User {
    
    static var userRegistration: String { (base + register).url }
    static var userLogin: String { (base + login).url }
}
