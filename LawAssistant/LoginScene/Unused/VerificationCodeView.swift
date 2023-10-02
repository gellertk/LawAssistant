//
//  OTPView.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 02.06.2023.
//

import SwiftUI

struct VerificationCodeView: View {
    
    @StateObject var viewModel = VerificationCodeViewModel()
    @FocusState private var isKeyboardShown: Bool
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(0..<6, id: \.self) { index in
                    self.otpTextBox(index)
                }
            }
            .background(content: {
                TextField("", text: self.$viewModel.otpText.limit(6))
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .frame(width: 1, height: 1)
                    .opacity(0.001)
                    .blendMode(.screen)
                    .focused(self.$isKeyboardShown)
            })
            .contentShape(Rectangle())
            .padding(.bottom, 20)
            .padding(.top, 10)
            
            Button {
                Task {
                    await self.viewModel.verifyOtp()
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
            .fullScreenCover(isPresented: self.$viewModel.isRootViewPresented) {
                MainView()
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.maroon)
            .cornerRadius(10)
            .disabled(self.viewModel.otpText.count != 6)
            .opacity(self.viewModel.otpText.count != 6 ?  0.4 : 1)
        }
        .padding(.all)
        .frame(maxHeight: .infinity, alignment: .top)
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Подтвердить") {
                    Task {
                        await self.viewModel.verifyOtp()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .onAppear {
            self.isKeyboardShown = true
        }
           
    }
    
    @ViewBuilder
    private func otpTextBox(_ index: Int) -> some View {
        ZStack {
            if self.viewModel.otpText.count > index {
                let startIndex = self.viewModel.otpText.startIndex
                let charIndex = self.viewModel.otpText.index (startIndex, offsetBy: index)
                let charToString = String(self.viewModel.otpText[charIndex])
                Text(charToString)

            } else {
                Text(" ")
            }
        }
        .frame(width: 45, height: 45)
        .background {
            let status = self.viewModel.otpText.count == index
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(status ? . black : .gray, lineWidth: status ? 1 : 0.5)
                .animation(.easeInOut(duration: 0.2), value: status)
        }
        .frame(maxWidth: .infinity)
    }

}

extension View {
    func disableWithOpacity(_ condition: Bool) -> some View {
        self.disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
}

struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        VerificationCodeView()
    }
}

extension Binding where Value == String {
    func limit(_ lenght: Int) -> Self {
        if self.wrappedValue.count > lenght {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(lenght))
            }

        }
        return self
    }
}
