import FileProvider
import SyncloomKit

/// Everything is implemented in SyncloomKit; this class only gives the system an entry point.
final class FileProviderExtension: SyncloomProviderExtension {
    required init(domain: NSFileProviderDomain) {
        Credentials.accessGroup = Bundle.main.object(forInfoDictionaryKey: "SyncloomKeychainGroup") as? String
        super.init(domain: domain)
    }
}
