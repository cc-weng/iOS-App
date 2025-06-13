//
//  View.swift
//  focus
//
//  Created by ccweng on 2025/6/13.
//

import Foundation
import SwiftUI

struct SafeAreaInsetsKey: PreferenceKey {
    static var defaultValue = EdgeInsets()
    static func reduce(value: inout EdgeInsets, nextValue: () -> EdgeInsets) {
        value = nextValue()
    }
}

extension View {
    func getSafeAreaInsets(_ safeInsets: Binding<EdgeInsets>) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SafeAreaInsetsKey.self, value: proxy.safeAreaInsets)
            }
            .onPreferenceChange(SafeAreaInsetsKey.self) { value in
                print("SafeAreaInsets: \(value)")
                safeInsets.wrappedValue = value
            }
        )
    }
}


extension View {
    // 简单参数
    func basePageView() -> some View {
        self.navigationDestination(for: RoutePath.self) { path in
            path.pageView()
        }
    }
    // 复杂参数
    func advancedPageView(@ViewBuilder destination: @escaping (_ path: RoutePath) -> some View) -> some View {
        self.navigationDestination(for: RoutePath.self, destination: destination)
    }
    
    // 自定义的 toolbar
    func toolbar(_ router: Router, backText: String? = "返回", iconLeft: String? = "chevron.left") -> some View {
        self.navigationBarBackButtonHidden().toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.pop()
                } label: {
                    HStack(spacing: 5) {
                        if iconLeft != nil {
                            Image(systemName: iconLeft!).fontWeight(.semibold)
                        }
                        if (backText != nil) {
                            Text(backText!)
                        }
                    }
                }
            }
        })
    }
}

//右滑返回
extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
