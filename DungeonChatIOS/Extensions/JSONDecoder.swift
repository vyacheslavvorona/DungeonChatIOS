//
//  JSONDecoder.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/21.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

import Foundation

import Foundation

extension JSONDecoder {
    
    static var iso8601: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
