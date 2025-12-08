import Synchronization
import Foundation

@MainActor
final class DepartmentClient: Sendable {
    static let shared = DepartmentClient()
    
    func getAllDepartments() async -> [Department] {
        do throws (InitializationError) {
            let fileUtils = FileUtils.shared
            
            guard let file = await fileUtils.getDepartmentFile() else { return [] }
            
            do {
                
                let decoder = JSONDecoder()
                
                let departments = try decoder.decode([Department].self, from: file.data(using: .utf8)!)
                return departments
            } catch {
                
                guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else {
                    return []
                }
                exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.DEPARTMENT_GET_ALL))
                
                return []
            }
        } catch InitializationError.sdkUninitialized {
            return []
        } catch {
            guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else {
                return []
            }
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.DEPARTMENT_GET_ALL))
            
            return []
        }
        
    }
    
    func getDefaultDepartment() async -> Department? {
        do throws(InitializationError) {
            let fileUtils = FileUtils.shared
            
            guard let file = await fileUtils.getDepartmentFile() else { return nil }
            
            do {
                let decoder = JSONDecoder()
                let departments = try decoder.decode([Department].self, from: Data(file.utf8))
                return departments.first(where: { $0.default })
            } catch {
                
                guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else {
                    return nil
                }
                exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.DEPARTMENT_GET_DEFAULT))
                
                return nil
            }
        } catch InitializationError.sdkUninitialized {
            return nil
        } catch {
            guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else {
                return nil
            }
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.DEPARTMENT_GET_DEFAULT))
            
            return nil
        }
    }
    
    func getDepartmentsByCountry(countryCode: String) async -> Optional<Department> {
        do throws (InitializationError) {
            let fileUtils = FileUtils.shared
            
            guard let file = await fileUtils.getDepartmentFile() else { return nil }
            
            do {
                
                let decoder = JSONDecoder()
                
                let departments = try decoder.decode([Department].self, from: file.data(using: .utf8)!)
                return departments.first{ $0.codes.contains(countryCode)}
            } catch {
                
                guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else {
                    return nil
                }
                exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.DEPARTMENT_GET_BY_COUNTRY))
                
                return nil
            }
        } catch InitializationError.sdkUninitialized {
            return nil
        } catch {
            guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else {
                return nil
            }
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.DEPARTMENT_GET_BY_COUNTRY))
            
            return nil
        }
    }
}
