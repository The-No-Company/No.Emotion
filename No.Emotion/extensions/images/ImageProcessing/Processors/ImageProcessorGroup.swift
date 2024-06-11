import CoreGraphics

struct ImageProcessorGroup: ImageProcessing {
    let processors: [ImageProcessing]

    init(processors: [ImageProcessing]) {
        self.processors = processors
    }

    func process(_ input: CGImage) -> CGImage {
        var resultImage = input

        for processor in processors {
            resultImage = processor.process(resultImage)
        }

        return resultImage
    }
}
