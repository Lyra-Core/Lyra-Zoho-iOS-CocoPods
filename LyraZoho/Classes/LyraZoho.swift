import Synchronization

@MainActor
public final class LyraZoho: Sendable {
    public static let shared = Mutex<LyraZoho>(LyraZoho())

    private init() {

    }

    public func initialize(config: LyraConfig, zohoConfig: ZohoConfig) {
        let coreInitializer = CoreInitializer.shared.withLock({ core in return core })

        coreInitializer.initialize(config: config)
        coreInitializer.initializeZoho(zohoConfig: zohoConfig)
    }

    public func isInitalized() -> Bool {
        let coreInitializer = CoreInitializer.shared.withLock({ core in return core })

        return coreInitializer.isInitialized()
    }

    public func isZohoInitialized() -> Bool {
        let coreInitializer = CoreInitializer.shared.withLock({ core in return core })

        return coreInitializer.isZohoInitialized()
    }

    public func getApiKey() -> String? {
        let coreInitializer = CoreInitializer.shared.withLock({ core in return core })

        return coreInitializer.getApiKey()
    }

    public func getConfig() -> LyraConfig? {
        let coreInitializer = CoreInitializer.shared.withLock({ core in return core })

        return coreInitializer.getConfig()
    }

    // Chat functionality = properly exposed
    public func startChatListeners(listener: ZohoChatListener?) throws(InitializationError) {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.startListeners(listener: listener)
    }

    public func openChat() throws(InitializationError) {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.open()
    }

    public func setChatDepartment(countryCode: String) throws(InitializationError) {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.setDepartment(countryCode: countryCode)
    }

    public func setChatLanguage(languageCode: String) throws(InitializationError) {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.setLanguage(languageCode: languageCode)
    }

    public func setChatQuestion() throws(InitializationError) {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.setQuestion()
    }

    public func setPageTitle(title: String) throws(InitializationError) {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.setPageTitle(title: title)
    }

    public func setAddtionalInforation(additionalInfo: ChatAdditionalInformation)
        throws(InitializationError)
    {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.setAdditionalInformation(additionalInfo: additionalInfo)
    }

    public func endChatSession() {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        chatClient.endSession()
    }
    
    public func showZohoLauncher() {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        chatClient.showZohoLauncher()
    }

    // Notification Functionality
    public func enablePushNotification(token: String, isTestDevice: Bool)
        throws(InitializationError)
    {
        let notificationClient = NotificationClient.shared.withLock({ notification in
            return notification
        })
        try notificationClient.enablePush(token: token, isTestDevice: isTestDevice)
    }

    public func handlePushNotification(
        data: [AnyHashable: Any]?, response: String?, actionIdentifier: String?
    ) throws(InitializationError) {
        let notificationClient = NotificationClient.shared.withLock({ notification in
            return notification
        })
        try notificationClient.handleNotification(
            userInfo: data, response: response, actionIdentifier: actionIdentifier)
    }

    public func isZohoPushNotification(data: [AnyHashable: Any]?) throws(InitializationError)
        -> Bool
    {
        let notificationClient = NotificationClient.shared.withLock({ notification in
            return notification
        })
        guard let response = try notificationClient.isZohoNotification(data: data) else {
            return false
        }
        return response
    }
    
    public func processNotificationwithInfo(info: [AnyHashable: Any]?) throws(InitializationError) {
        let notificationClient = NotificationClient.shared.withLock({ notification in
            return notification
        })
        
        try notificationClient.processNotificationWithInfo(info: info)
    }

    // Department Functionality
    public func getAllDepartments() -> [Department] {
        let departmentClient = DepartmentClient.shared.withLock({ department in return department })
        return departmentClient.getAllDepartments()
    }

    public func getDefaultDepartment() -> Department? {
        let departmentClient = DepartmentClient.shared.withLock({ department in return department })
        return departmentClient.getDefaultDepartment()
    }

    public func getDepartmentsByCountryCode(countryCode: String) -> Department? {
        let departmentClient = DepartmentClient.shared.withLock({ department in return department })
        return departmentClient.getDepartmentsByCountry(countryCode: countryCode)
    }

}
