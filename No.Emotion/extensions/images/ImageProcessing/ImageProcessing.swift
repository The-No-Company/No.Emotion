import CoreGraphics

public protocol ImageProcessing {
    func process(_ input: CGImage) -> CGImage
}
