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
    var isSecureFiled = false
    var showError: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(showError ? .red : .gray)
                        .font(.system(size: 14))
                }
                
                if isSecureFiled {
                    SecureField(placeholder, text: $text)
                        .font(.system(size: 14))
                } else {
                    TextField("", text: $text)
                        .font(.system(size: 14))
                }
            }
            
            Divider()
                .background(showError ? Color.red : Color.clear)
        }
    }
}


#Preview {
    InputView(text: .constant(""), title: "Email Addreaa", placeholder: "yourname@example.com")
}
