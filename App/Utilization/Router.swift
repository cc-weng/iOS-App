//
//  Router.swift
//  focus
//
//  Created by ccweng on 2025/6/13.
//

import Foundation
import SwiftUI

enum RoutePath: Hashable {
    // 首页
    case index
    // 个人中心
    case profile
    // WebView
    case webview(_ url: URL)
    // case testPath(_ index: Int) // 带参数
    
    func pageView() -> some View {
        switch self {
        case .index:
            return AnyView(IndexView())
        case .profile:
            return AnyView(ProfileView())
        case .webview(let url):
            return AnyView(WebView(url: url))
        }
    }
}

protocol RouterDelegate {
    associatedtype Route = RoutePath
    
    func push(_ path: Route)
    func pop()
    func popToRoot()
    func popUntil(_ path: Route)
}

class Router: ObservableObject, RouterDelegate {
    @Published var history: [RoutePath] = []
    
    func push(_ path: RoutePath) {
        self.history.append(path)
    }
    
    func pop() {
        self.history.removeLast()
    }
    
    func popToRoot() {
        self.history.removeAll()
    }
    
    func popUntil(_ path: RoutePath) {
        if (history.count == 0) {
            return
        }
        if self.history.last != path {
            self.history.removeLast()
            popUntil(path)
        }
    }
}
