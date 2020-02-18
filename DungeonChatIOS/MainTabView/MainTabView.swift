//
//  MainTabView.swift
//  DungeonChatIOS
//
//  Created by vorona.vyacheslav on 2020/02/18.
//  Copyright © 2020 vorona.vyacheslav. All rights reserved.
//

import SwiftUI

protocol MainTabViewModelProtocol {
    
}

struct MainTabView: View {
    @ObservedObject var viewModel = MainTabViewModel()
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

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
