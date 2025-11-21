import Foundation

public final class ChatEvent : NSObject {
    public var type: ChatEventType
    public var chatId: Optional<String>
    public var visitorChat: Optional<VisitorChatData>
    
    public init(type: ChatEventType, chatId: Optional<String>, visitorChat: Optional<VisitorChatData>) {
        self.type = type
        self.chatId = chatId
        self.visitorChat = visitorChat
    }
}
