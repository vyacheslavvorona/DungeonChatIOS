//
//  Array.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/20.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

extension Array where Element == String {
    
    public var url: String {
        "/" + joined(separator: "/")
    }
}
