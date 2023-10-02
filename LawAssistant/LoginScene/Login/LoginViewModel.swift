//
//  OTPViewModel.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 02.06.2023.
//

import Firebase

final class LoginViewModel: ObservableObject {
    
    @Published var showAlert = false
    @Published var errorMsg = ""
    @Published var isLoading = false
    
    @Published var isLoggedIn = false
    
    private var handler = Auth.auth().addStateDidChangeListener{_,_ in }
    
    init(){
        handler = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self else { return }
            if user != nil {
                self.isLoggedIn = true
            } else {
                self.isLoggedIn = false
            }
        }
    }
    
    deinit {
        Auth.auth().removeStateDidChangeListener(handler)
    }
        
    func sendCode(to number: String) async {
        self.isLoading = true
        do {
            let result = try await PhoneAuthProvider.provider().verifyPhoneNumber("+" + number, uiDelegate: nil)
            self.isLoading = false
            UserDefaults.standard.set(result, forKey: "authVerificationId")
        } catch {
            await self.handleError(error: error.localizedDescription)
        }
    }
    
    private func handleError(error: String) async {
        await MainActor.run {
            self.isLoading = false
            self.errorMsg = error
            self.showAlert.toggle()
        }
    }
    
}
