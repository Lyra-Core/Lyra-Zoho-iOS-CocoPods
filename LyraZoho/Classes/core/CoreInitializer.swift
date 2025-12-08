import Mobilisten
import Synchronization

@MainActor
final class CoreInitializer {
    static let shared = CoreInitializer()
    
    private var zohoInitialized = false
    private var zohoAppKey: Optional<String> = nil
    private var zohoAccessKey: Optional<String> = nil
    private var exceptionHandlingCallback: Optional<ExceptionHandlingCallback> = nil
    private var environment: Environment = .PRODUCTION
    
    private init() {}
    
    
    func initializeZoho(zohoConfig: ZohoConfig) {
        do throws(any Error) {
            self.exceptionHandlingCallback = zohoConfig.exceptionHandlingCallback
            ZohoSalesIQ.initWithAppKey(zohoConfig.appKey, accessKey: zohoConfig.accessKey) {
                error in
                do throws (InitializationError) {
                    if error == nil {
                        self.zohoAppKey = zohoConfig.appKey
                        self.zohoAccessKey = zohoConfig.accessKey
                        self.zohoInitialized = true
                    } else {
                        guard let errorCode = error?.code else { throw InitializationError.noErrorCode }
                        guard let errorMessage = error?.message else { throw InitializationError.noErrorMessage(errorCode) }
                        
                        self.exceptionHandlingCallback?.onError(
                            error: ErrorEvent(
                                errorCode: errorCode, errorMessage: errorMessage, errorLocation: ErrorLocation.CORE_INITIALIZE))
                    }
                } catch InitializationError.noErrorCode {
                    // TODO: Figure out how to handle this
                }
                catch InitializationError.noErrorMessage {
                    // TODO: Figure out how to handle this
                }
                catch {
                    // TODO: Figure out how to handle this
                }
            }
        } catch {
            self.exceptionHandlingCallback?.onException(
                error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.CORE_INITIALIZE))
        }
    }
    
    func setEnvironment(environment: Environment) throws (InitializationError) {
        do throws (InitializationError) {
            let isZohoSDKInitialized = CoreInitializer.shared.isZohoInitialized()
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }
            self.environment = environment
            FileUtils.shared.clearDepartmentCache()
        } catch {
            
            guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else { return }
            
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.CORE_SET_ENVIRONMENT))
        }
    }
    
    func isZohoInitialized() -> Bool {
        return self.zohoInitialized
    }
    
    func getZohoAppKey() -> Optional<String> {
        return self.zohoAppKey
    }
    
    func getZohoAccessKey() -> Optional<String> {
        return self.zohoAccessKey
    }
    
    func getExceptionHandlingCallback() -> Optional<ExceptionHandlingCallback> {
        return self.exceptionHandlingCallback
    }
    
    func getEnvironment() -> Environment {
        return self.environment
    }
}
