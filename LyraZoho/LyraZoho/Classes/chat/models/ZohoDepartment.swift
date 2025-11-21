import Foundation

public final class ZohoDepartment: NSObject {
    public var id: String
    public var name: String
    public var available: Bool
    
    init(id: String, name: String, available: Bool) {
        self.id = id
        self.name = name
        self.available = available
    }
}
