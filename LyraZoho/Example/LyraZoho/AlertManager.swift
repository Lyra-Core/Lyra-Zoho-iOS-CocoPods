import SwiftUI


final class AlertManager: ObservableObject {
    static let shared = AlertManager()
    
    @Published var title: String?
    @Published var message: String?
        
    func show(_ text: String, title: String) {
        self.title = title
        message = text
    }
}
