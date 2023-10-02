//
//  ContentView.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 08.11.2022.
//

import SwiftUI
import iPhoneNumberField
import Firebase

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    
    @State private var phoneNumber = "995591627802"
    @State private var code = ""
    @State private var isCodeTextShown = false
    @State private var isVerificationCodeViewPresented = false
    
    private var errorText: String? = nil
    
    var body: some View {
        VStack {
            if self.viewModel.isLoggedIn {
                MainView()
            } else{
                self.loginBody
            }
        }
//        .alert("Error", isPresented: self.$viewModel.hasError) {
//        } message: {
//            Text(vm.errorMessage)
//        }
    }
    
    var loginBody: some View {
        NavigationView {
            VStack {
                iPhoneNumberField(text: self.$phoneNumber)
                    .flagHidden(false)
                    .flagSelectable(true)
                    .autofillPrefix(true)
//                    .prefixHidden(true)
                    .clearButtonMode(.always)
                    .defaultRegion("ge")
                    .maximumDigits(10)
                    .countryCodePlaceholderColor(.maroon)
                    .font(UIFont(size: 25, weight: .bold, design: .rounded))
                                .padding()
   
                Button {
                    Task {
                        self.isVerificationCodeViewPresented = true
                        await self.viewModel.sendCode(to: self.phoneNumber)
                    }
                } label: {
                    if self.viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Продолжить")
                            .frame(maxWidth: .infinity)
                            .tint(.white)
                    }
                }
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.maroon)
                .cornerRadius(10)
                .disabled(self.phoneNumber == "")
                .opacity(self.phoneNumber == "" ?  0.4 : 1)
                
                NavigationLink(
                    destination: VerificationCodeView(),
                    isActive: self.$isVerificationCodeViewPresented,
                    label: { EmptyView() }
                )
                .isDetailLink(false) // This prevents unexpected navigation issues
                
            }
            .navigationTitle("Вход")
            .padding()
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
