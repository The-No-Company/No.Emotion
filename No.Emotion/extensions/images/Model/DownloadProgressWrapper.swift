import Combine

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
public final class DownloadProgressWrapper: ObservableObject {
    @Published public var progress: Float?

    public init(progress: Float? = nil) {
        self.progress = progress
    }
}
