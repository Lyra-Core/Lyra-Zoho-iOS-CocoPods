@preconcurrency import Mobilisten
import Synchronization
import Foundation

@MainActor
final class ChatClient: Sendable {
    static let shared = ChatClient()
    
    private var chatListener: Optional<ZohoChatListener> = nil
    private var isListenersStarted = false
    private var languageCode = "en"
    private var title = ""
    
    
    func startListeners(listener: Optional<ZohoChatListener>) throws(InitializationError) {
        do throws (InitializationError) {
            let isZohoSDKInitialized = CoreInitializer.shared.isZohoInitialized()
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }
            
            do throws (any Error) {
                DispatchQueue.main.async(execute: {
                    self.showZohoLauncher()
                    let zohoDelegateListener = ZohoChatListenerDelegate(listener: self.chatListener, chatClient: self)
                    ZohoSalesIQ.Chat.delegate = zohoDelegateListener
                })
            } catch {
                
                guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else { return }
                
                exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.CHAT_START_LISTENERS))
            }
        } catch InitializationError.sdkUninitialized {
            throw .sdkUninitialized
        } catch {
            
            guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else { return }
            
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.CHAT_START_LISTENERS))
        }
    }
    
    func open() throws (InitializationError) {
        do throws (InitializationError) {
            let isZohoSDKInitialized = CoreInitializer.shared.isZohoInitialized()
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }
            
            do throws (any Error) {
                ZohoSalesIQ.Chat.show();
            } catch {
                
                guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else { return }
                
                exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.CHAT_START_LISTENERS))
            }
        } catch InitializationError.sdkUninitialized {
            throw .sdkUninitialized
        } catch {
            
            guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else { return }
            
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.CHAT_START_LISTENERS))
        }
    }
    
    func setDepartment(countryCode: String) async throws (InitializationError) {
        do throws (InitializationError) {
            let isZohoSDKInitialized = CoreInitializer.shared.isZohoInitialized()
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }
            
            do throws (DepartmentError) {
                var department = await DepartmentClient.shared.getDepartmentsByCountry(countryCode: countryCode)
                
                if (department == nil) {
                    department = await DepartmentClient.shared.getDefaultDepartment()
                    
                    if (department == nil) {
                        throw .notFound
                    }
                }
                
                let departmentName = department!.name
                
                ZohoSalesIQ.Chat.setDepartment(departmentName)
            } catch {
                guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else { return }
                
                exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.CHAT_SET_DEPARTMENT))
            }
        } catch InitializationError.sdkUninitialized {
            throw .sdkUninitialized
        } catch {
            
            guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else { return }
            
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.CHAT_SET_DEPARTMENT))
        }
    }
    
    func setLanguage(languageCode: String) throws (InitializationError) {
        do throws (InitializationError) {
            let isZohoSDKInitialized = CoreInitializer.shared.isZohoInitialized()
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }
            
            let languageMap: [String:String] = [
                "zh-hant" : "zh_TW",
                "pt-br" : "pt_BR",
                "pt-pt" : "pt_PT",
                "es-la" : "es_LA"
            ]
            if (languageMap.keys.contains(where: {languageCode.lowercased() == $0.lowercased()})){
                ZohoSalesIQ.Chat.setLanguageWithCode(languageMap[languageCode]!)
                self.languageCode = languageMap[languageCode]!
            } else {
                ZohoSalesIQ.Chat.setLanguageWithCode(languageCode)
                self.languageCode = languageCode
            }
            
            try self.setQuestion()
            try self.setPageTitle(title: title)
        } catch InitializationError.sdkUninitialized {
            throw .sdkUninitialized
        } catch {
            
            guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else { return }
            
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.CHAT_SET_DEPARTMENT))
        }
    }
    
    func setAdditionalInformation(additionalInfo: ChatAdditionalInformation) throws (InitializationError) {
        do throws (InitializationError) {
            let isZohoSDKInitialized = CoreInitializer.shared.isZohoInitialized()
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }
            
            ZohoSalesIQ.Visitor.addInfo("Company Name", value: additionalInfo.companyName)
            ZohoSalesIQ.Visitor.addInfo("Primary Need", value: additionalInfo.primaryNeed)
            if (additionalInfo.primaryNeed == "None") {
                ZohoSalesIQ.Visitor.addInfo("Page", value: "Support")
                ZohoSalesIQ.Visitor.addInfo("Potential Risk", value: "Yes")
            } else {
                ZohoSalesIQ.Visitor.addInfo("Page", value: "Services")
                ZohoSalesIQ.Visitor.addInfo("Potential Risk", value: "Yes")
            }
        } catch InitializationError.sdkUninitialized {
            throw .sdkUninitialized
        } catch {
            
            guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else { return }
            
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.CHAT_SET_DEPARTMENT))
        }
    }
    
    func setPageTitle(title: String) throws (InitializationError) {
        do throws (InitializationError) {
            let isZohoSDKInitialized = CoreInitializer.shared.isZohoInitialized()
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }
            self.title = title
            ZohoSalesIQ.Tracking.setPageTitle(title)
        } catch InitializationError.sdkUninitialized {
            throw .sdkUninitialized
        } catch {
            
            guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else { return }
            
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.CHAT_SET_DEPARTMENT))
        }
    }
    
    func setQuestion() throws (InitializationError) {
        do throws (InitializationError) {
            let isZohoSDKInitialized = CoreInitializer.shared.isZohoInitialized()
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }
            
            
            let fileUtils = FileUtils.shared
            
            guard let file = fileUtils.getFile(named: self.languageCode, extensioned: "json") else { return }
            
            do {
                
                let decoder = JSONDecoder()
                
                let questions = try decoder.decode(Translation.self, from: file.data(using: .utf8)!)
                ZohoSalesIQ.Visitor.setQuestion(questions.ZOHO_QUESTION)
            } catch {
                
                guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else {
                    return
                }
                exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.DEPARTMENT_GET_ALL))
                
                return
            }
        } catch InitializationError.sdkUninitialized {
            throw .sdkUninitialized
        } catch {
            
            guard let exceptionHandlingCallback = CoreInitializer.shared.getExceptionHandlingCallback() else { return }
            
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.CHAT_SET_DEPARTMENT))
        }
    }
    
    func endSession() {
        self.endChat();
        ZohoSalesIQ.Launcher.show(.whenActiveChat);
        DispatchQueue.main.async {
            ZohoSalesIQ.Chat.clearData();
            
        }
    }
    
    func endChat() {
        DispatchQueue.main.async {
            ZohoSalesIQ.Chat.getList(filter: .open) { (error, chats) in
                if (chats?.count ?? 0 > 0)
                {
                    ZohoSalesIQ.Chat.endSession(referenceID: chats?[0].referenceID ?? "")
                }
            }
        }
    }
    
    @MainActor
    func showZohoLauncher() {
        DispatchQueue.main.async {
            ZohoSalesIQ.Chat.getList(filter: .open) { (error, chats) in
                if (chats?.count ?? 0 > 0)
                {
                    let currentDate = Date();
                    let endTime = chats?[0].lastMessage.time ?? Date();
                    self.calculateTimeDifferenceInHours(date1:endTime, date2:currentDate);
                    ZohoSalesIQ.Launcher.show(.whenActiveChat);
                }
                else
                {
                    ZohoSalesIQ.Launcher.show(.whenActiveChat);
                }
            }
        }
    }
    
    func calculateTimeDifferenceInHours(date1: Date, date2: Date) {
        let timeDifferenceInSeconds = date2.timeIntervalSince(date1)
        let timeDifferenceInHours = timeDifferenceInSeconds / 3600
        if(timeDifferenceInHours > 2){
            self.endSession()
        }
    }
    
}
