enum DepartmentError: Error {
    case notFound
}

extension DepartmentError: CustomStringConvertible {
    public var description: String {
        switch self {
            case .notFound:
                return "Department not found"
        }
    }
}
