//
//  AppVM.swift
//  focus
//
//  Created by ccweng on 2025/6/13.
//

import Foundation

enum TabPath {
    case index
    case profile
}

final class AppVM: ObservableObject {
    @Published var selectedTab: TabPath = TabPath.index
}
