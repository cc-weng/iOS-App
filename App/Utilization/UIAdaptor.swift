//
//  UIAdaptor.swift
//  focus
//
//  Created by ccweng on 2025/6/13.
//

import Foundation
import UIKit

struct UIAdapter {
    static var share = UIAdapter()
    
    // 标准宽度
    var base: CGFloat = 375.0
    
    fileprivate var adapterScale: CGFloat?
}

protocol UIAdapterable {
    associatedtype UIAdapterType
    var uiAdapter: UIAdapterType { get }
}

extension UIAdapterable {
    func adapterScale() -> CGFloat {
        if let scale = UIAdapter.share.adapterScale {
            return scale
        } else {
            let width = UIScreen.main.bounds.size.width
            /// 参考标准
            let referenceWidth = UIAdapter.share.base
            let scale = width / referenceWidth
            UIAdapter.share.adapterScale = scale
            return scale
        }
    }
}

extension Int: UIAdapterable {
    public typealias UIAdapterType = Int
    public var uiAdapter: Int {
        let scale = adapterScale()
        let value = Double(self) * scale
        return Int(value)
    }
}

extension CGFloat: UIAdapterable {
    public typealias UIAdapterType = CGFloat
    public var uiAdapter: CGFloat {
        let scale = adapterScale()
        let value = self * scale
        return value
    }
}

extension Double: UIAdapterable {
    public typealias UIAdapterType = Double
    public var uiAdapter: Double {
        let scale = adapterScale()
        let value = self * scale
        return value
    }
}

extension Float: UIAdapterable {
    public typealias UIAdapterType = Float
    public var uiAdapter: Float {
        let scale = adapterScale()
        let value = self * Float(scale)
        return value
    }
}


extension CGSize: UIAdapterable {
    public typealias UIAdapterType = CGSize
    public var uiAdapter: CGSize {
        let scale = adapterScale()
        let width = self.width * scale
        let height = self.height * scale
        return CGSize(width: width, height: height)
    }
}

extension CGRect: UIAdapterable {
    public typealias UIAdapterType = CGRect
    public var uiAdapter: CGRect {
        
        /// 不参与屏幕rect
        if self == UIScreen.main.bounds {
            return self
        }
        let scale = adapterScale()
        let x = origin.x * scale
        let y = origin.y * scale
        let width = size.width * scale
        let height = size.height * scale
        return CGRect(x: x, y: y, width: width, height: height)
    }
}

extension UIFont: UIAdapterable {
    public typealias UIAdapterType = UIFont
    public var uiAdapter: UIFont {
        let scale = adapterScale()
        let pointSzie = self.pointSize * scale
        let fontDescriptor = self.fontDescriptor
        return UIFont(descriptor: fontDescriptor, size: pointSzie)
    }
}
