@preconcurrency import Mobilisten

public protocol ZohoChatListener {
    func onChatViewOpen(chatId: String)
    func onChatViewClose(chatId: String)
    func onChatOpened(chatEvent: ChatEvent)
    func onChatClosed(chatEvent: ChatEvent)
    func onChatAttended(chatEvent: ChatEvent)
    func onChatMissed(chatEvent: ChatEvent)
    func onChatReOpened(chatEvent: ChatEvent)
    func onRating(chatEvent: ChatEvent)
    func onFeedback(chatEvent: ChatEvent)
    func onQueuePositionChange(chatEvent: ChatEvent)
}
