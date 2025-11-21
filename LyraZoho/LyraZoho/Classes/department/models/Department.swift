import Foundation

public final class Department: NSObject, Codable {
    public var name: String
    public var codes: [String]
    public var `default`: Bool   
}
