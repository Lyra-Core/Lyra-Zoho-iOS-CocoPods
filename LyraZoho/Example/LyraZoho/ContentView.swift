//
//  ContentView.swift
//  ZohoTest
//
//  Created by Velocity Cubed on 2025/10/28.
//

import SwiftUI
import LyraZoho
import Synchronization

struct ContentView: View {
    @State private var fullText: String = "Begining of test"
    
    @State private var isEnglish = true
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Open Zoho Chat") {
                let lyraShare = LyraZoho.shared.withLock({ share in return share })
                
                do throws (InitializationError) {
                    try lyraShare.openChat()
                    fullText.append("Opened chat")
                } catch .sdkUninitialized {
                    AlertManager.shared.show("SDK Uninitialized", title: "Error Occured")
                } catch {
                    AlertManager.shared.show("Unknown Error", title: "Error Occured")
                }
                AlertManager.shared.show("Open Chat Clickeed", title: "Chat")
            }
            Button("Close Zoho Chat") {
                let lyraShare = LyraZoho.shared.withLock({ share in return share })
                
                do throws (InitializationError) {
                    try lyraShare.endChatSession()
                    fullText.append("Ended chat")
                } catch .sdkUninitialized {
                    AlertManager.shared.show("SDK Uninitialized", title: "Error Occured")
                } catch {
                    AlertManager.shared.show("Unknown Error", title: "Error Occured")
                }
                AlertManager.shared.show("End Chat Clickeed", title: "Chat")
            }
            
            Button("Toggle Language") {
                isEnglish.toggle()
                
                let lyraShare = LyraZoho.shared.withLock({ share in return share })
                if isEnglish {
                    do throws(InitializationError) {
                        try lyraShare.setChatLanguage(languageCode: "en")
                        fullText.append("Toggled chat to english")
                    } catch .sdkUninitialized {
                        AlertManager.shared.show("SDK Uninitialized", title: "Error Occured")
                    } catch {
                        AlertManager.shared.show("Unknown Error", title: "Error Occured")
                    }
                } else {
                    do throws(InitializationError) {
                        try lyraShare.setChatLanguage(languageCode: "ar")
                        fullText.append("Toggled chat to arabic")
                    } catch .sdkUninitialized {
                        AlertManager.shared.show("SDK Uninitialized", title: "Error Occured")
                    } catch {
                        AlertManager.shared.show("Unknown Error", title: "Error Occured")
                    }
                }
            }
            
            Button("Set Question") {
                let lyraShare = LyraZoho.shared.withLock({ share in return share })
                do throws(InitializationError) {
                    try lyraShare.setChatQuestion()
                    fullText.append("Set chat question")
                } catch .sdkUninitialized {
                    AlertManager.shared.show("SDK Uninitialized", title: "Error Occured")
                } catch {
                    AlertManager.shared.show("Unknown Error", title: "Error Occured")
                }
            }
            
            TextEditor(text: $fullText)
            
        }
        .alert("Error", isPresented: .constant(AlertManager.shared.message != nil)) {
            Button("OK") {
                AlertManager.shared.message = nil
            }
        } message: {
            Text(AlertManager.shared.message ?? "")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
