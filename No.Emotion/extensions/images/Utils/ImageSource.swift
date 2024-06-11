#if canImport(MobileCoreServices)
import MobileCoreServices
#endif

#if canImport(Cocoa)
import Cocoa
#endif

func preferredFileExtension(forTypeIdentifier uti: String) -> String? {
    UTTypeCopyPreferredTagWithClass(uti as CFString, kUTTagClassFilenameExtension)?.takeUnretainedValue() as String?
}
