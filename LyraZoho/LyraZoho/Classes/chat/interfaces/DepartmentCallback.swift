public protocol DepartmentCallback {
    func onSuccess(departments: [Department])
    func onError(error: String)
}
