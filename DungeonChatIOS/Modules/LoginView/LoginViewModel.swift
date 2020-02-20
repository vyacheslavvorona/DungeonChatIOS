//
//  LoginViewModel.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/19.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

import Combine
import RealmSwift
import DungeonChatCore

final class LoginViewModel: LoginViewModelProtocol {
    
    init() {
        
        NetworkManager.post(.registerUser, parameters: User(email: "some@email.com"))
            .map { (value: UserContent) -> Int in
                
            }
            
    }
}
