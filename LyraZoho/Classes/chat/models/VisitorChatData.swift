import Foundation

public final class VisitorChatData: NSObject {
    public var chatId: String
    public var question: Optional<String>
    public var attenderName: Optional<String>
    public var attenderEmail: Optional<String>
    public var attenderId: Optional<String>
    public var isBotAttender: Bool
    public var departmentName: Optional<String>
    public var chatStatus: Optional<String>
    public var unreadCount: Int
    public var feedback: Optional<String>
    public var rating: Optional<String>
    public var lastMessage: Optional<String>
    public var queuePosition: Int
    
    init(chatId: String, question: Optional<String>, attenderName: Optional<String>, attenderEmail: Optional<String>, attenderId: Optional<String>, isBotAttender: Bool, departmentName: Optional<String>, chatStatus: Optional<String>, unreadCount: Int, feedback: Optional<String>, rating: Optional<String>, lastMessage: Optional<String>, queuePosition: Int) {
        self.chatId = chatId
        self.question = question
        self.attenderName = attenderName
        self.attenderEmail = attenderEmail
        self.attenderId = attenderId
        self.isBotAttender = isBotAttender
        self.departmentName = departmentName
        self.chatStatus = chatStatus
        self.unreadCount = unreadCount
        self.feedback = feedback
        self.rating = rating
        self.lastMessage = lastMessage
        self.queuePosition = queuePosition
    }
}
