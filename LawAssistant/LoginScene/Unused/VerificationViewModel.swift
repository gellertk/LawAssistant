//
//  VerificationViewModel.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 08.09.23.
//

import FirebaseAuth
import SwiftUI

final class VerificationCodeViewModel: ObservableObject {
    
    @Published var otpFields = Array(repeating: "", count: 6)
    @Published var otpText = ""
    @Published var errorToast = ""
    @Published var isLoading = false
    @Published var isRootViewPresented = false
        
    func verifyOtp() async {
        self.isLoading = true
        guard let verificationId = UserDefaults.standard.object(forKey: "authVerificationId") as? String else { return }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: self.otpText)
        do {
            try await Auth.auth().signIn(with: credential)
            await MainActor.run {
                self.isRootViewPresented = true
            }
        } catch {
            self.errorToast = error.localizedDescription
        }
        await MainActor.run {
            self.isLoading = false
        }
    }
    
}
