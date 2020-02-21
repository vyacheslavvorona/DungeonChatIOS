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
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        
        User.register(with: UserContent(email: "ios8@user.com", password: "mupass11"))
            .sink(receiveCompletion: { someCrap in
                print(someCrap)
            }) { (user: UserContent) in
                print("User registration")
                print(user)
            }
            .store(in: &cancelables)
        
        User.login(with: UserContent(email: "ios6@user.com", password: "mupass11"))
            .sink(receiveCompletion: { someCrap in
                print(someCrap)
            }) { (token: AuthToken) in
                print("User login")
                print(token)
            }
            .store(in: &cancelables)
    }
}
