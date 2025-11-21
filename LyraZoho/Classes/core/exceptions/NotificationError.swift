enum NotificationError: Error {
    case unknownNotificationError
    case actionIdentifierNotProvided
    case userInfoNotProvided
}

extension NotificationError : CustomStringConvertible {
    public var description: String {
        switch self {
            case .unknownNotificationError:
                return "Unknown Notification Error"
        case .actionIdentifierNotProvided:
            return "Action Identifier Not Provided"
        case .userInfoNotProvided:
            return "User Info Not Provided"
        }
    }
}
