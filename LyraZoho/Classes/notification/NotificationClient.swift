import Foundation
import Mobilisten
import Synchronization

@MainActor
final class NotificationClient: Sendable {
    static let shared = NotificationClient()

    func enablePush(token: String, isTestDevice: Bool) throws(InitializationError) {
        do throws(InitializationError) {
            let isZohoSDKInitialized = CoreInitializer.shared.isZohoInitialized()
            
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }

            do {
                ZohoSalesIQ.enablePush(token, isTestDevice: isTestDevice, mode: .production)
            } catch {

                guard
                    let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback()
                    
                else { return }

                exceptionHandlingCallback.onException(
                    error: ExceptionEvent(
                        exception: error.localizedDescription,
                        exceptionLocation: ExceptionLocation.NOTIFICATION_ENABLE_PUSH))
            }

        } catch InitializationError.sdkUninitialized {
            throw .sdkUninitialized
        } catch {

            guard
                let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback()
                
            else { return }

            exceptionHandlingCallback.onException(
                error: ExceptionEvent(
                    exception: error.localizedDescription,
                    exceptionLocation: ExceptionLocation.NOTIFICATION_ENABLE_PUSH))
        }
    }

    func handleNotification(
        userInfo: [AnyHashable: Any]?, response: String?, actionIdentifier: String?
    ) throws(InitializationError) {
        do throws(InitializationError) {
            let isZohoSDKInitialized = CoreInitializer.shared.isZohoInitialized()
            
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }
            guard let isZohoNotification = try self.isZohoNotification(data: userInfo) else {
                throw .unknownNotificationError
            }
            do throws(NotificationError) {
                
                guard let internalActionIdentifier = actionIdentifier else {
                    throw .actionIdentifierNotProvided
                }
                guard let internalUserInfo = userInfo else { throw .userInfoNotProvided }
                if isZohoNotification {
                    switch actionIdentifier {
                    case "reply":
                        ZohoSalesIQ.handleNotificationAction(internalUserInfo, response: response)
                    case "tap":
                        ZohoSalesIQ.processNotificationWithInfo(internalUserInfo)
                    default:
                        break
                    }
                }
            } catch {

                guard
                    let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback()
                    
                else { return }

                exceptionHandlingCallback.onException(
                    error: ExceptionEvent(
                        exception: error.localizedDescription,
                        exceptionLocation: ExceptionLocation.NOTIFICATION_ENABLE_PUSH))
            }
        } catch InitializationError.sdkUninitialized {
            throw .sdkUninitialized
        } catch {

            guard
                let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback()
                
            else { return }

            exceptionHandlingCallback.onException(
                error: ExceptionEvent(
                    exception: error.localizedDescription,
                    exceptionLocation: ExceptionLocation.NOTIFICATION_ENABLE_PUSH))
        }
    }

    func isZohoNotification(data: [AnyHashable: Any]?)
        throws(InitializationError) -> Bool?
    {
        do throws(InitializationError) {
            let isZohoSDKInitialized = CoreInitializer.shared.isZohoInitialized()
            
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }
            do {
                return ZohoSalesIQ.isMobilistenNotification(data)
            } catch {

                guard
                    let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback()
                    
                else { return nil }

                exceptionHandlingCallback.onException(
                    error: ExceptionEvent(
                        exception: error.localizedDescription,
                        exceptionLocation: ExceptionLocation.NOTIFICATION_ENABLE_PUSH))
                return nil
            }
        } catch InitializationError.sdkUninitialized {
            throw .sdkUninitialized
        } catch {

            guard
                let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback()
                
            else { return nil }

            exceptionHandlingCallback.onException(
                error: ExceptionEvent(
                    exception: error.localizedDescription,
                    exceptionLocation: ExceptionLocation.NOTIFICATION_ENABLE_PUSH))

            return nil
        }
    }
    
    public func processNotificationWithInfo(info: [AnyHashable: Any]?) throws(InitializationError) {
        do throws(InitializationError) {
            let isZohoSDKInitialized = CoreInitializer.shared.isZohoInitialized()
            
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }

            ZohoSalesIQ.processNotificationWithInfo(info)            

        } catch InitializationError.sdkUninitialized {
            throw .sdkUninitialized
        } catch {

            guard
                let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback()
                
            else { return }

            exceptionHandlingCallback.onException(
                error: ExceptionEvent(
                    exception: error.localizedDescription,
                    exceptionLocation: ExceptionLocation.NOTIFICATION_ENABLE_PUSH))
        }
    }

}
