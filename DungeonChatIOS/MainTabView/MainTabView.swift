//
//  MainTabView.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/18.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

import SwiftUI

protocol MainTabViewModelProtocol: ObservableObject {
    
}

struct MainTabView<ViewModel: MainTabViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Text("First View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("first")
                        Text("First")
                    }
                }
                .tag(0)
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Second")
                    }
                }
                .tag(1)
        }
    }
}

#if DEBUG
// MARK: - Previews
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(viewModel: MainTabViewModel())
    }
}
#endif
