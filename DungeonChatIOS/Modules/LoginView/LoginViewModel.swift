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
        let user = UserContent(email: "ios4@user.com", password: "mupass11")
        NetworkManager.post(.registerUser, parameters: user)
            .sink(receiveCompletion: { someCrap in
                print(someCrap)
            }) { (user: UserContent) in
                print(user)
            }
            .store(in: &cancelables)
    }
}
