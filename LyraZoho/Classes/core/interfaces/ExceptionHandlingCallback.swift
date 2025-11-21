public protocol ExceptionHandlingCallback {
    func onError(error: ErrorEvent)
    func onException(error: ExceptionEvent)
}
