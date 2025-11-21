import Mobilisten

final class ZohoChatListenerDelegate: NSObject, ZohoSalesIQChatDelegate {
    private let listener: Optional<ZohoChatListener>
    private let chatClient: ChatClient
    
    init(listener: Optional<ZohoChatListener>, chatClient: ChatClient) {
        self.listener = listener
        self.chatClient = chatClient
    }
    
    func chatOpened(chat: Mobilisten.SIQVisitorChat?) {
        if (chat == nil){
            return
        }
                
        listener?.onChatOpened(chatEvent: unwrapChatData(chat: chat))
    }
    
    func chatAttended(chat: Mobilisten.SIQVisitorChat?) {
        if (chat == nil){
            return
        }
                
        listener?.onChatOpened(chatEvent: unwrapChatData(chat: chat))
    }
    
    func chatMissed(chat: Mobilisten.SIQVisitorChat?) {
        if (chat == nil){
            return
        }
                
        listener?.onChatMissed(chatEvent: unwrapChatData(chat: chat))
    }
    
    func chatClosed(chat: Mobilisten.SIQVisitorChat?) {
        Task { [chatClient] in
            await chatClient.showZohoLauncher()
        }
        
        if (chat == nil){
            return
        }
                
        listener?.onChatClosed(chatEvent: unwrapChatData(chat: chat))
    }
    
    func chatReopened(chat: Mobilisten.SIQVisitorChat?) {
        if (chat == nil){
            return
        }
                
        listener?.onChatReOpened(chatEvent: unwrapChatData(chat: chat))
    }
    
    func chatRatingRecieved(chat: Mobilisten.SIQVisitorChat?) {
        if (chat == nil){
            return
        }
                
        listener?.onRating(chatEvent: unwrapChatData(chat: chat))
    }
    
    func chatFeedbackRecieved(chat: Mobilisten.SIQVisitorChat?) {
        if (chat == nil){
            return
        }
                
        listener?.onFeedback(chatEvent: unwrapChatData(chat: chat))
    }
    
    func chatQueuePositionChanged(chat: Mobilisten.SIQVisitorChat?) {
        if (chat == nil){
            return
        }
                
        listener?.onQueuePositionChange(chatEvent: unwrapChatData(chat: chat))
    }
    
    func unreadCountChanged(_ count: Int) { }
    
    func shouldOpenURL(_ url: URL, in chat: Mobilisten.SIQVisitorChat?) -> Bool {
        return true
    }
    
    private func unwrapChatData(chat: Optional<Mobilisten.SIQVisitorChat>) -> ChatEvent {
        let chatId = chat?.referenceID ?? ""
        let question = chat?.question ?? ""
        let attenderName = chat?.attenderName ?? ""
        let attenderEmail = chat?.attenderEmail ?? ""
        let attenderId = chat?.attenderID ?? ""
        let isBotAttender = chat?.isBotAttender ?? false
        let departmentName = chat?.departmentName ?? ""
        let chatStatus = chat?.status ?? nil
        let unreadCount = chat?.unreadCount ?? 0
        let feedback = chat?.feedback ?? ""
        let rating = chat?.rating ?? ""
        let lastMessage = chat?.referenceID ?? ""
        let queuePosition = chat?.queuePosition ?? 0
        
        let convertedStatus: Optional<String> = switch(chatStatus) {
            case .open: "open"
            case .triggered: "triggered"
            case .proactive: "proactive"
            case .connected: "connected"
            case .waiting: "waiting"
            case .missed: "missed"
            case .closed: "closed"
            case .ended: "ended"
            case .all: "all"
            default: nil
            
        }
        
        let visistorChatData: VisitorChatData = VisitorChatData(chatId: chatId, question: question, attenderName: attenderName, attenderEmail: attenderEmail, attenderId: attenderId, isBotAttender: isBotAttender, departmentName: departmentName, chatStatus: convertedStatus, unreadCount: unreadCount, feedback: feedback, rating: rating, lastMessage: lastMessage, queuePosition: queuePosition)
        
        return ChatEvent(type: .CHAT_OPENED, chatId: chat?.referenceID, visitorChat: visistorChatData)
    }
}
