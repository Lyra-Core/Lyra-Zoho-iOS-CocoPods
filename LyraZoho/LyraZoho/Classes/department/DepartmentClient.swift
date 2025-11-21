import Synchronization
import Foundation

final class DepartmentClient {
    static let shared = Mutex<DepartmentClient>(DepartmentClient())
    
    func getAllDepartments() -> [Department] {
        do throws (InitializationError) {
            let isSDKInitialized = CoreInitializer.shared.withLock({ core in  return core.isInitialized() })
            if !isSDKInitialized {
                throw .sdkUninitialized
            }
            
            let fileUtils = FileUtils.shared.withLock({ fileUtils in return fileUtils })
            
            guard let file = fileUtils.getFile(named: "departments", extensioned: "json") else { return [] }
            
            do {
                
                let decoder = JSONDecoder()
                
                let departments = try decoder.decode([Department].self, from: file.data(using: .utf8)!)
                return departments
            } catch {
                
                guard let exceptionHandlingCallback = CoreInitializer.shared.withLock({ core in  return core.getExceptionHandlingCallback() }) else {
                    return []
                }
                exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.DEPARTMENT_GET_ALL))
                
                return []
            }
        } catch InitializationError.sdkUninitialized {
            return []
        } catch {
            guard let exceptionHandlingCallback = CoreInitializer.shared.withLock({ core in  return core.getExceptionHandlingCallback() }) else {
                return []
            }
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.DEPARTMENT_GET_ALL))
            
            return []
        }
        
    }
    
    func getDefaultDepartment() -> Department? {
        do throws(InitializationError) {
            let isSDKInitialized = CoreInitializer.shared.withLock({ core in return core.isInitialized() })
            if !isSDKInitialized {
                throw .sdkUninitialized
            }
            let fileUtils = FileUtils.shared.withLock({ fileUtils in return fileUtils })
            
            guard let file = fileUtils.getFile(named: "departments", extensioned: "json") else { return nil }
            
            do {
                let decoder = JSONDecoder()
                let departments = try decoder.decode([Department].self, from: Data(file.utf8))
                return departments.first(where: { $0.default })
            } catch {
                
                guard let exceptionHandlingCallback = CoreInitializer.shared.withLock({ core in  return core.getExceptionHandlingCallback() }) else {
                    return nil
                }
                exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.DEPARTMENT_GET_DEFAULT))
                
                return nil
            }
        } catch InitializationError.sdkUninitialized {
            return nil
        } catch {
            guard let exceptionHandlingCallback = CoreInitializer.shared.withLock({ core in  return core.getExceptionHandlingCallback() }) else {
                return nil
            }
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.DEPARTMENT_GET_DEFAULT))
            
            return nil
        }
    }
    
    func getDepartmentsByCountry(countryCode: String) -> Optional<Department> {
        do throws (InitializationError) {
            let isSDKInitialized = CoreInitializer.shared.withLock({ core in  return core.isInitialized() })
            if !isSDKInitialized {
                throw .sdkUninitialized
            }
            let fileUtils = FileUtils.shared.withLock({ fileUtils in return fileUtils })
            
            guard let file = fileUtils.getFile(named: "departments", extensioned: "json") else { return nil }
            
            do {
                
                let decoder = JSONDecoder()
                
                let departments = try decoder.decode([Department].self, from: file.data(using: .utf8)!)
                return departments.first{ $0.codes.contains(countryCode)}
            } catch {
                
                guard let exceptionHandlingCallback = CoreInitializer.shared.withLock({ core in  return core.getExceptionHandlingCallback() }) else {
                    return nil
                }
                exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.DEPARTMENT_GET_BY_COUNTRY))
                
                return nil
            }
        } catch InitializationError.sdkUninitialized {
            return nil
        } catch {
            guard let exceptionHandlingCallback = CoreInitializer.shared.withLock({ core in  return core.getExceptionHandlingCallback() }) else {
                return nil
            }
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.DEPARTMENT_GET_BY_COUNTRY))
            
            return nil
        }
    }
}
