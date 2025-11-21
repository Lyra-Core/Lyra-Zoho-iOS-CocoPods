import Mobilisten
import Synchronization

final class CoreInitializer {
    static let shared = Mutex<CoreInitializer>(CoreInitializer())
    
    private let initialized = Mutex<Bool>(false)
    private let zohoInitialized = Mutex<Bool>(false)
    private var apiKey: Optional<String> = nil
    private var config: Optional<LyraConfig> = nil
    private var zohoAppKey: Optional<String> = nil
    private var zohoAccessKey: Optional<String> = nil
    private var exceptionHandlingCallback: Optional<ExceptionHandlingCallback> = nil
    
    private init() {}
    
    func initialize(config: LyraConfig) {
        if !initialized.withLock({ initialized in return initialized }) {
            self.config = config
            self.apiKey = config.apiKey
            initialized.withLock({ initialized in initialized = true })
        }
    }
    
    func initializeZoho(zohoConfig: ZohoConfig) {
        do throws(any Error) {
            self.exceptionHandlingCallback = zohoConfig.exceptionHandlingCallback
            ZohoSalesIQ.initWithAppKey(zohoConfig.appKey, accessKey: zohoConfig.accessKey) {
                error in
                do throws (InitializationError) {
                    if error == nil {
                        self.zohoAppKey = zohoConfig.appKey
                        self.zohoAccessKey = zohoConfig.accessKey
                        self.zohoInitialized.withLock({ initialized in initialized = true })
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
    
    func isInitialized() -> Bool {
        self.initialized.withLock({ initialized in return initialized })
    }
    
    func isZohoInitialized() -> Bool {
        self.zohoInitialized.withLock({ initialized in return initialized })
    }
    
    func getApiKey() -> Optional<String> {
        return self.apiKey
    }
    
    func getConfig() -> Optional<LyraConfig> {
        return self.config
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
}
