//
//  WebView.swift
//  focus
//
//  Created by ccweng on 2025/6/1.
//

import SwiftUI
import WebKit

private struct InternalWebView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }}

struct WebView: View {
    
    var url: URL
    @EnvironmentObject var router: Router
    
    init(url: URL) {
        self.url = url
    }
    
    var body: some View {
        InternalWebView(url: url)
            .toolbar(router)
    }
}

#Preview {
    WebView(url: URL(string: "https://www.ccweng.cc")!)
}
