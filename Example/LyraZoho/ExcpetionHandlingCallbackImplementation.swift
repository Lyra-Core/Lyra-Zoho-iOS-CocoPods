import LyraZoho
import SwiftUI

class ExcpetionHandlingCallbackImplementation : ExceptionHandlingCallback {
    func onError(error: ErrorEvent) {
        AlertManager.shared.show("Error: \(error.errorMessage). Error location: \(error.errorLocation)", title: "Error Occured")
    }
    
    func onException(error: ExceptionEvent) {
        
    }
}
