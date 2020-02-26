//
//  RegisterView.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/25.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

import SwiftUI

protocol RegisterViewModelProtocol {
    var email: String { get }
    var password: String { get }
    
    func register()
}

// MARK: - RegisterView
struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
            TextField("Password", text: $viewModel.password)
            Button("register", action: viewModel.register)
        }
        .padding()
    }
}

#if DEBUG
// MARK: - Previews
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: RegisterViewModel())
    }
}
#endif
