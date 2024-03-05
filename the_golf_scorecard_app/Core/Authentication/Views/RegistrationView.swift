//
//  RegistrationView.swift
//  the_golf_scorecard_app
//
//  Created by user254089 on 3/4/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var address1 = ""
    @State private var address2 = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zipCode = ""
    @State private var birthday = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack{
            Image("golf_logo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            // log in fields
            ScrollView {
                VStack(spacing: 24) {
                    InputView(text: $firstName, title: "First Name", placeholder: "First Name")
                    InputView(text: $lastName, title: "Last Name", placeholder: "Last Name")
                    
                    InputView(text: $phoneNumber, title: "Phone Number ", placeholder: "123 469 7890")
                    
                    InputView(text: $address1, title: "Address Line 1 ", placeholder: "100 Borad St.")
                    InputView(text: $address2, title: "Address Line 2", placeholder: "e.g. Apt 3")
                    InputView(text: $city, title: "City ", placeholder: "New York City")
                    InputView(text: $state, title: "State", placeholder: "NY")
                    InputView(text: $zipCode, title: "Zip Code", placeholder: "07285")
                    
                    InputView(text: $birthday, title: "Birthday", placeholder: "YYYY-MM-DD")
                    InputView(text: $email, title: "Email Address ", placeholder: "yourname@example.com")
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter Password", isSecureFiled: true)
                    InputView(text: $confirmPassword, title: "Confirm Passowrd", placeholder: "Confirm your Password", isSecureFiled: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
            }
            .frame(height: UIScreen.main.bounds.height - 400)            // log in button
            Button {
                Task {
                    try await viewModel.register(withEmail: email, password: password, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, address1: address1, address2: address2, city: city, state: state, zipCode: zipCode, birthday: birthday)
                }
            } label: {
                HStack {
                    Text("Register")
                        .fontWeight(.semibold)
                    Image("arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32,height: 48)
            }
            .background(Color(.systemBlue  ))
            .cornerRadius(10)
            .padding(.top, 24)
            
            
            Spacer()
            
            Button{
                dismiss()
            } label: {
                HStack(spacing: 2){
                    Text("Have have an account?")
                    Text("Log in").fontWeight(.bold)
                }
                .font(.system(size: 14))            }
        }
    }
}

#Preview {
    RegistrationView()
}
