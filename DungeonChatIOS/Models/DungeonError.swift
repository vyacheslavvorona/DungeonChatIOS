//
//  DungeonError.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/19.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

enum DungeonError: Error {
    case api(code: Int? = nil, message: String = "Unknown")
    case coding(message: String = "Unable to encode/decode")
    
    case unknown
}
