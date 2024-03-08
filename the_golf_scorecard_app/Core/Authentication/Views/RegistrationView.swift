//
//  RegistrationView.swift
//  the_golf_scorecard_app
//
//  Created by user254089 on 3/4/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var firstName = ""
    @State private var showFirstName = false
    @State private var lastName = ""
    @State private var showLastName = false
    @State private var phoneNumber = ""
    @State private var showPhoneNumber = false
    @State private var address1 = ""
    @State private var showAddress1 = false
    @State private var address2 = ""
    @State private var city = ""
    @State private var showCity = false
    @State private var state = ""
    @State private var showState = false
    @State private var zipCode = ""
    @State private var showZip = false
    @State private var birthday = ""
    @State private var showDOB = false
    @State private var email = ""
    @State private var showEmail = false
    @State private var password = ""
    @State private var showPassword = false
    @State private var confirmPassword = ""
    @State private var showConfirmPassword = false
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
                    InputView(text: $firstName, title: "First Name", placeholder: "First Name", showError: showFirstName)

                    InputView(text: $lastName, title: "Last Name", placeholder: "Last Name", showError: showLastName)
                    
                    InputView(text: $email, title: "Email Address ", placeholder: "yourname@example.com",  showError: showEmail)
                    InputView(text: $password, title: "Password", placeholder: "Enter a password", isSecureFiled: true, showError: showPassword)
                    
                    InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your Password", isSecureFiled: true, showError: showConfirmPassword)
                    
                    InputView(text: $phoneNumber, title: "Phone Number ", placeholder: "123 469 7890", showError: showPhoneNumber)
                    
                    InputView(text: $birthday, title: "Birthday", placeholder: "YYYY-MM-DD", showError: showDOB)
                    
                    InputView(text: $address1, title: "Address Line 1 ", placeholder: "100 Borad St.", showError: showAddress1)
                    
                    InputView(text: $address2, title: "Address Line 2", placeholder: "e.g. Apt 3")
                    
                    InputView(text: $city, title: "City ", placeholder: "New York City", showError: showCity)

                    InputView(text: $state, title: "State", placeholder: "NY", showError: showState)
                    InputView(text: $zipCode, title: "Zip Code", placeholder: "07285", showError: showZip)
                }
                .padding(.horizontal)
                .padding(.top, 12)
            }
            .frame(height: UIScreen.main.bounds.height - 400)            // log in button
            Button {
                showFirstName = firstName.isEmpty
                showLastName = lastName.isEmpty
                showEmail = email.isEmpty
                showPassword = email.isEmpty
                showPhoneNumber = phoneNumber.isEmpty
                showDOB = birthday.isEmpty
                showAddress1 = address1.isEmpty
                showCity = state.isEmpty
                showState = state.isEmpty
                showZip = state.isEmpty
                
                guard !showFirstName && !showLastName && !showEmail && !showPassword && !showPhoneNumber && !showDOB && !showAddress1 && !showCity && !showState && !showZip else {return}
                
                
                Task {
                    do {
                        try await viewModel.register(withEmail: email, password: password, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, address1: address1, address2: address2, city: city, state: state, zipCode: zipCode, birthday: birthday)
                                // Navigate back to the login screen upon success
                        dismiss()
                    } 
                    catch {
                        // Handle registration error (e.g., display an error message)
                        print("Registration failed: \(error.localizedDescription)")
                    }
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
                .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    RegistrationView()
}
