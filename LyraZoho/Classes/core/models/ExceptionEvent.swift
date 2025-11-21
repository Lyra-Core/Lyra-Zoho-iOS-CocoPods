import Foundation
public final class ExceptionEvent: NSObject {
    var exception: String
    var exceptionLocation: ExceptionLocation

    init(exception: String, exceptionLocation: ExceptionLocation) {
        self.exception = exception
        self.exceptionLocation = exceptionLocation
    }
}
