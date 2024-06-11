import Foundation

extension FileManager {
    static var appCachesDirectoryURL: URL {
        return self.default.appCachesDirectoryURL
    }

    var appCachesDirectoryURL: URL {
        return urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
}
