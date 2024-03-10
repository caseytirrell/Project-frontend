//
//  InputView.swift
//  the_golf_scorecard_app
//
//  Created by user254089 on 3/4/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureFiled: Bool = false
    var showError: Bool = false
    var validationIcon: Image? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            HStack {
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(showError ? .red : .gray)
                            .font(.system(size: 14))
                    }
                    
                    if isSecureFiled {
                        SecureField("", text: $text)
                            .font(.system(size: 14))
                    } else {
                        TextField("", text: $text)
                            .font(.system(size: 14))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if let validationIcon = validationIcon {
                    validationIcon
                        .foregroundColor(.green)
                        .transition(.scale)
                }
            }
            
            Divider()
                .background(showError ? Color.red : Color(.separator)) // Adjusted for potential typo in Color.clear
        }
    }
}

// Preview
struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Email Address", placeholder: "yourname@example.com")
    }
}
