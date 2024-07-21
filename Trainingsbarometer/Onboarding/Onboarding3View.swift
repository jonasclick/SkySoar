//
//  Onboarding3View.swift
//  Trainingsbarometer
//
//  Created by Jonas Vetsch on 05.07.2024.
//

import SwiftUI

struct Onboarding3View: View {
    
    @State private var isWebsitePresented = false
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                
                // Title
                Text("Disclaimer")
                    .font(.mainHeadline)
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                
                // Text EN
                JustifiedText(text: localizedDisclaimerText())
                    .opacity(0.7)
                    .padding(.horizontal, -5)
                    .frame(height: 330)
                    .allowsHitTesting(false) // remove unnecessary scroll ability from JustifiedText
                
                // Link to website
                Text("Developers Website")
                    .font(.system(size: 12, weight: .light))
                    .underline()
                    .opacity(0.7)
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                    .onTapGesture {
                        isWebsitePresented.toggle()
                    }
            }
            .padding(.horizontal)
            .sheet(isPresented: $isWebsitePresented, content: {
                WebsiteView(title: "Developers Website", url: "https://github.com/jonasclick/Trainingsbarometer")
            })
            
            // Button "Continue" to next onboarding step
            NavigationLink(destination: Onboarding4View()) {
                Text("I understand")
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    .background(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func localizedDisclaimerText() -> String {
        return (Locale.current.language.languageCode?.identifier ?? "") == "de" ?
        "Diese Anwendung soll Segelflugpilot*innen und deren Sicherheit unterstützen, indem benutzer-bereitgestellte Informationen dargestellt und einfach zugänglich gemacht werden.\n\nDie Entwickler raten stark davon ab, sich ausschließlich auf die Informationen in dieser Anwendung zu verlassen. Die*der Nutzer*in muss alle Informationen immer unabhängig überprüfen, da die Anwendung funktionale Fehler oder Ungenauigkeiten enthalten kann und von Benutzer*innen eingegebene Daten fehlerhaft sein können.\n\nDie Entwickler lehnen jegliche Haftung für Handlungen und Folgen ab, ob im Aviatikkontext oder nicht, die auf dieser Anwendung basieren." :
        "This application is designed to assist your flying hobby and enhance safety by presenting user-provided information in a clear and accessible manner.\n\nHowever, reliance solely on the information provided by this application is not recommended. It is crucial to verify all information independently, as the application may contain functional errors or inaccuracies, and user-entered data may be incorrect.\n\nThe developers and the application itself disclaim any liability for actions or decisions, flying-related or not, made based on the information provided by the application."
    }
}

//#Preview {
//    Onboarding3View()
//}
