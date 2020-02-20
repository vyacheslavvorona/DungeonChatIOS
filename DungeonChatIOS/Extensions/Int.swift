//
//  Int.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/20.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

extension Int {
    
    var pathComponent: String {
        "\\\(self)"
    }
}

extension Optional where Wrapped == Int {
    
    var pathComponent: String {
        guard let this = self else { return "" }
        return "\\\(this)"
    }
}
