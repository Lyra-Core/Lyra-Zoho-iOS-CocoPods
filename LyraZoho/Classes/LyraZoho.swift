import Synchronization

@MainActor
public final class LyraZoho: Sendable {
    public static let shared = LyraZoho()

    private init() {

    }

    public func initialize(zohoConfig: ZohoConfig) {
        let coreInitializer = CoreInitializer.shared

        coreInitializer.initializeZoho(zohoConfig: zohoConfig)
    }
        
    /*
     This function sets what environment the SDK is running in. The default is Production.
     
     - Parameters:
        - environment: Can be either .STAGING or .PRODUCTION
     
     - Throws: InitializationError
     
     */
    public func setEnvironment(environment: Environment) throws(InitializationError) {
        let coreInitializer = CoreInitializer.shared
        
        try coreInitializer.setEnvironment(environment: environment)
    }

    public func isZohoInitialized() -> Bool {
        let coreInitializer = CoreInitializer.shared

        return coreInitializer.isZohoInitialized()
    }

    // Chat functionality = properly exposed
    public func startChatListeners(listener: ZohoChatListener?) throws(InitializationError) {
        let chatClient = ChatClient.shared
        try chatClient.startListeners(listener: listener)
    }

    public func openChat() throws(InitializationError) {
        let chatClient = ChatClient.shared
        try chatClient.open()
    }

    public func setChatDepartment(countryCode: String) async throws(InitializationError) {
        let chatClient = ChatClient.shared
        try await chatClient.setDepartment(countryCode: countryCode)
    }

    public func setChatLanguage(languageCode: String) throws(InitializationError) {
        let chatClient = ChatClient.shared
        try chatClient.setLanguage(languageCode: languageCode)
    }

    public func setChatQuestion() throws(InitializationError) {
        let chatClient = ChatClient.shared
        try chatClient.setQuestion()
    }

    public func setPageTitle(title: String) throws(InitializationError) {
        let chatClient = ChatClient.shared
        try chatClient.setPageTitle(title: title)
    }

    public func setAddtionalInforation(additionalInfo: ChatAdditionalInformation)
        throws(InitializationError)
    {
        let chatClient = ChatClient.shared
        try chatClient.setAdditionalInformation(additionalInfo: additionalInfo)
    }

    public func endChatSession() {
        let chatClient = ChatClient.shared
        chatClient.endSession()
    }
    
    public func showZohoLauncher() {
        let chatClient = ChatClient.shared
        chatClient.showZohoLauncher()
    }

    // Notification Functionality
    public func enablePushNotification(token: String, isTestDevice: Bool)
        throws(InitializationError)
    {
        let notificationClient = NotificationClient.shared
        
        try notificationClient.enablePush(token: token, isTestDevice: isTestDevice)
    }

    public func handlePushNotification(
        data: [AnyHashable: Any]?, response: String?, actionIdentifier: String?
    ) throws(InitializationError) {
        let notificationClient = NotificationClient.shared
        
        try notificationClient.handleNotification(
            userInfo: data, response: response, actionIdentifier: actionIdentifier)
    }

    public func isZohoPushNotification(data: [AnyHashable: Any]?) throws(InitializationError)
        -> Bool
    {
        let notificationClient = NotificationClient.shared
        
        guard let response = try notificationClient.isZohoNotification(data: data) else {
            return false
        }
        return response
    }
    
    public func processNotificationwithInfo(info: [AnyHashable: Any]?) throws(InitializationError) {
        let notificationClient = NotificationClient.shared
        
        try notificationClient.processNotificationWithInfo(info: info)
    }

    // Department Functionality
    public func getAllDepartments() async -> [Department] {
        let departmentClient = DepartmentClient.shared
        return await departmentClient.getAllDepartments()
    }

    public func getDefaultDepartment() async -> Department? {
        let departmentClient = DepartmentClient.shared
        return await departmentClient.getDefaultDepartment()
    }

    public func getDepartmentsByCountryCode(countryCode: String) async -> Department? {
        let departmentClient = DepartmentClient.shared
        return await departmentClient.getDepartmentsByCountry(countryCode: countryCode)
    }

}
