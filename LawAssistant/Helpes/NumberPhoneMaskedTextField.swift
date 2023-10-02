//
//  NumberPhoneMaskedTextField.swift
//  LawAssistant
//
//  Created by Kirill Gellert on 02.06.2023.
//

import SwiftUI

struct NumberPhoneMaskView: View {
    
    let maskPhone = "+X(XXX)-XXX-XX-XX"
    let maskPlaceholder = "+7(___)___-____"
    @State var text = ""
    
    var body: some View {
        VStack {
            let textChangedBinding = Binding<String>(
                get: {
                    FilterNumberPhone.format(with: self.maskPhone, phone: self.text)
                },
                set: {
                    self.text = $0
                }
            )
            TextField(self.maskPlaceholder, text: textChangedBinding)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.maroon, style: StrokeStyle(lineWidth: 1.0)))
        }
    }
}

struct NumberPhoneMaskView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPhoneMaskView()
    }
}
