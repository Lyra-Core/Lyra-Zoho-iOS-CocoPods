import LyraZoho
class ChatListener: ZohoChatListener {
    func onChatViewOpen(chatId: String) {
        AlertManager.shared.show("Chat View Opened \(chatId)", title: "Chat")
    }
    
    func onChatOpened(chatEvent: ChatEvent) {
        AlertManager.shared.show("Chat Opened \(chatEvent.chatId)", title: "Chat")
    }
    func onChatViewClose(chatId: String){
        AlertManager.shared.show("Chat View Closed \(chatId)", title: "Chat")
    }
    func onChatViewOpen(chatEvent: ChatEvent){
        AlertManager.shared.show("Chat View Opened \(chatEvent.chatId)", title: "Chat")
    }
    func onChatClosed(chatEvent: ChatEvent){
        AlertManager.shared.show("Chat View Closed \(chatEvent.chatId)", title: "Chat")
    }
    func onChatAttended(chatEvent: ChatEvent){
        AlertManager.shared.show("Chat Attended \(chatEvent.chatId)", title: "Chat")
    }
    func onChatMissed(chatEvent: ChatEvent){
        AlertManager.shared.show("Chat Missed \(chatEvent.chatId)", title: "Chat")
    }
    func onChatReOpened(chatEvent: ChatEvent){
        AlertManager.shared.show("Chat Reopened \(chatEvent.chatId)", title: "Chat")
    }
    func onRating(chatEvent: ChatEvent){
        AlertManager.shared.show("Chat On Rating \(chatEvent.chatId)", title: "Chat")
    }
    func onFeedback(chatEvent: ChatEvent){
        AlertManager.shared.show("Chat On Feedback \(chatEvent.chatId)", title: "Chat")
    }
    func onQueuePositionChange(chatEvent: ChatEvent){
        AlertManager.shared.show("Chat On Queue Position Change \(chatEvent.chatId)", title: "Chat")
    }
}
