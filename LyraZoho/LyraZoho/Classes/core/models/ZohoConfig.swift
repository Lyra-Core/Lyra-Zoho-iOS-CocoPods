import Foundation

public final class ZohoConfig: NSObject {
    var appKey: String
    var accessKey: String
    var exceptionHandlingCallback: ExceptionHandlingCallback

    public init(appKey: String, accessKey: String, exceptionHandlingCallback: ExceptionHandlingCallback) {
        self.appKey = appKey
        self.accessKey = accessKey
        self.exceptionHandlingCallback = exceptionHandlingCallback
    }
}
