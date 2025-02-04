//
//  RegisterViewModel.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/25.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

import Combine
import RealmSwift
import DungeonChatCore

final class RegisterViewModel: ObservableObject, Identifiable, RegisterViewModelProtocol {
    private var cancelables = Set<AnyCancellable>()
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    func register() {
        User.register(with: UserContent(email: email, password: password))
            .sink(receiveCompletion: { someCrap in
                print(someCrap)
            }) { (user: UserContent) in
                print("User registration")
                print(user)
            }
        .store(in: &cancelables)
    }
}
