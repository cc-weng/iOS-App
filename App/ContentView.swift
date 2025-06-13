//
//  ContentView.swift
//  focus
//
//  Created by ccweng on 2025/6/12.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var router = Router()
    @StateObject var viewModel = AppVM()
    
    var body: some View {
        NavigationStack(path: $router.history) {
            ZStack(alignment: .bottom) {
                if #available(iOS 18.0, *) {
                    TabView(selection: $viewModel.selectedTab) {
                        Tab("首页", systemImage: "house", value: TabPath.index) {
                            IndexView()
                        }
                        Tab("档案", systemImage: "person", value: TabPath.profile) {
                            ProfileView()
                        }
                    }
                } else {
                    TabView(selection: $viewModel.selectedTab) {
                        IndexView().tag(TabPath.index).tabItem {
                            Label("首页", systemImage: "house")
                        }
                        ProfileView().tag(TabPath.profile).tabItem {
                            Label("档案", systemImage: "person")
                        }
                    }
                }
            }
            .basePageView()
        }
        .environmentObject(router)
    }
}

#Preview {
    ContentView()
}
