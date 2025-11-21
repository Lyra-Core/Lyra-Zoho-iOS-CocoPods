import Foundation

public final class ChatAdditionalInformation: NSObject, Codable {
    public var companyName: String
    public var primaryNeed: String
    
    public init(companyName: String, primaryNeed: String) {
        self.companyName = companyName
        self.primaryNeed = primaryNeed
    }
}
