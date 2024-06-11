import Combine
import ImageIO
import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
public protocol ImageProxy {
    var cgImage: CGImage { get }

    var cgOrientation: CGImagePropertyOrientation? { get }

    #if canImport(UIKit)
    var uiImage: UIImage { get }
    #endif

    #if canImport(AppKit) && !targetEnvironment(macCatalyst)
    var nsImage: NSImage { get }
    #endif

    var isAnimated: Bool { get }
}

#if canImport(UIKit)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(macOS, unavailable)
extension ImageProxy {
    public var image: Image {
        guard let cgOrientation = cgOrientation else {
            return Image(uiImage: uiImage)
        }

        return Image(decorative: cgImage, scale: 1.0, orientation: Image.Orientation(cgOrientation))
    }
}

extension ImageProxy {
    public var size: CGSize {
        let size_aspect = uiImage.size

        print(size_aspect.width)
        print(size_aspect.height)

        if size_aspect.width == 4032.0 && size_aspect.height == 3024 {
            let ratio = size_aspect.height / size_aspect.width

            var new_width = UIScreen.main.bounds.size.width / 2.4

            let new_height = new_width / ratio

            return CGSize(width: Int(new_width), height: Int(new_height))
        }

        let ratio = size_aspect.width / size_aspect.height
        var new_width = UIScreen.main.bounds.size.width / 1.7

        if size_aspect.height > size_aspect.width {
            new_width = UIScreen.main.bounds.size.width / 2.4
        }
        let new_height = new_width / ratio

        return CGSize(width: Int(new_width), height: Int(new_height))
    }
}

extension ImageProxy {
    public var uiimage: UIImage {
        return uiImage
    }
}

extension ImageProxy {
    public var news: CGSize {
        let size_aspect = uiImage.size

        let ratio = size_aspect.width / size_aspect.height
        let new_height: CGFloat = 100

        let new_width = new_height * ratio

        return CGSize(width: Int(new_width), height: Int(new_height))
    }
}

#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
@available(macOS 10.15, *)
@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension ImageProxy {
    public var image: Image {
        return Image(nsImage: nsImage)
    }
}
#endif

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
struct ImageWrapper: ImageProxy {
    init(cgImage: CGImage, cgOrientation: CGImagePropertyOrientation?) {
        self.cgImage = cgImage
        self.cgOrientation = cgOrientation
    }

    let cgImage: CGImage

    let cgOrientation: CGImagePropertyOrientation?

    #if canImport(UIKit)

    var uiImage: UIImage {
        return UIImage(cgImage: cgImage)
    }

    #endif

    #if canImport(AppKit) && !targetEnvironment(macCatalyst)

    var nsImage: NSImage {
        return NSImage(cgImage: cgImage, size: NSZeroSize)
    }

    #endif

    var isAnimated: Bool {
        return false
    }
}

#if canImport(UIKit)

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
struct AnimatedImageWrapper: ImageProxy {
    init(uiImage: UIImage) {
        self.uiImage = uiImage
    }

    var cgImage: CGImage {
        uiImage.cgImage!
    }

    var cgOrientation: CGImagePropertyOrientation? { nil }

    let uiImage: UIImage

    var isAnimated: Bool {
        return true
    }
}

#endif

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
extension Image.Orientation {
    fileprivate init(_ cgOrientation: CGImagePropertyOrientation) {
        switch cgOrientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        }
    }
}
