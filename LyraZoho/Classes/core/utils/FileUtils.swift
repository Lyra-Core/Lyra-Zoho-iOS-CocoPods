import Synchronization
import Foundation

final class FileUtils {
    static let shared = FileUtils()
    
    func getFile(named: String, extensioned: String) -> String? {
        let myBundle = Bundle(for: Self.self)
        
        guard let resourceBunldeURL = myBundle.url(forResource: "LyraZoho", withExtension: "bundle") else { return nil }
        guard let resourceBundle = Bundle(url: resourceBunldeURL) else { return nil }
        
        guard let url = resourceBundle.url(forResource: named, withExtension: extensioned) else { return nil }
        return try? String(contentsOf: url, encoding: .utf8)
    }
}
