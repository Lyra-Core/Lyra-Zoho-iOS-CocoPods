public enum InitializationError: Error {
    case noErrorCode
    case noErrorMessage(Int)
    case sdkUninitialized
    case zohoSDKUninitialized
    case unknownNotificationError
}

extension InitializationError: CustomStringConvertible {
    public var description: String {
        switch self {
            case .noErrorCode:
                return "No error code provided by zoho"
            case .noErrorMessage(let code):
                return "No error message provided by Zoho for error code \(code)"
            case .sdkUninitialized:
                return "LyraZoho SDK has not been initialized"
            case .zohoSDKUninitialized:
                return "Zoho SDK has not been initialized"
            case .unknownNotificationError:
                return "Unknown notification error"
        }
    }
}
