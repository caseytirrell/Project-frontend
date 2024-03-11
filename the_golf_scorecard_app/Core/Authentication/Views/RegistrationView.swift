//
//  RegistrationView.swift
//  the_golf_scorecard_app
//
//  Created by user254089 on 3/4/24.
//

import SwiftUI
import PhotosUI

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
    @State private var birthday = Date()
    @State private var showDOB = false
    @State private var email = ""
    @State private var showEmail = false
    @State private var password = ""
    @State private var profileImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var showPassword = false
    @State private var confirmPassword = ""
    @State private var showConfirmPassword = false
    @State private var passwordMatch = true
    @State private var firstNameErrors: [String] = []
    @State private var lastNameErrors: [String] = []
    @State private var emailErrors: [String] = []
    @State private var passwordErrors: [String] = []
    @State private var phoneNumberErrors: [String] = []
    @State private var zipCodeErrors: [String] = []
    @State private var stateErrors: [String] = []

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    enum ValidationType {
        case nonEmpty
        case email
    }
    
    func validateText(text: String, validationType: ValidationType) -> [String] {
        
        var errors: [String] = []
        
        switch validationType {
        case .nonEmpty:
            if text.isEmpty {
                errors.append("This Field must be filled in.")
            }
        case .email:
            if !text.contains("@") || !text.contains(".") {
                errors.append("Please enter a valid email address")
            }
        }
        return errors
    }
    
    func validatePassword(password: String) -> [String] {
        
        var errors: [String] = []
        if !password.contains(where: { $0.isLowercase }) {
            errors.append("Password must contain atleast 1 lowercase letter.")
        }
        if !password.contains(where: { $0.isUppercase}) {
            errors.append("Password must contain atelast 1 upper case letter.")
        }
        if !password.contains(where: { $0.isNumber}) {
            errors.append("Password must contain atleast 1 number.")
        }
        if !password.contains(where: { !$0.isLetter && !$0.isNumber}) {
            errors.append("Password must contain 1 non-alphanumeric character.")
        }
        if password.count < 6 {
            errors.append("Password must be atleast 6 characters long.")
        }
        if password.count > 4096 {
            errors.append("Password length is too long.")
        }
        return errors
    }
    
    func validatePhoneNumber(phoneNumber: String) -> [String] {
        
        var errors: [String] = []
        let digits = phoneNumber.filter { $0.isNumber }
        if digits.count != 10 {
            errors.append("Phone number must be exactly 10 digits(no hyphens).")
        }
        return errors
    }
    
    func validateZipcode(zipCode: String) -> [String] {
        
        var errors: [String] = []
        let digits = zipCode.filter { $0.isNumber }
        if digits.count != 5 {
            errors.append("Zip code must be exactly 5 digits.")
        }
        return errors
    }
    
    func validateState(state: String) -> [String] {
        
        var errors: [String] = []
        let letters = state.filter { $0.isLetter }
        if letters.count != 2 {
            errors.append("State Field must be exactly 2 characters.")
        }
        return errors
    }
    
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
                    if !firstNameErrors.isEmpty {
                        ForEach(firstNameErrors, id :\.self) { error in
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }

                    InputView(text: $lastName, title: "Last Name", placeholder: "Last Name", showError: showLastName)
                    if !lastNameErrors.isEmpty {
                        ForEach(lastNameErrors, id :\.self) { error in
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    InputView(text: $email, title: "Email Address ", placeholder: "yourname@example.com",  showError: showEmail)
                    if !emailErrors.isEmpty {
                        ForEach(emailErrors, id: \.self) { error in
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    InputView(text: $password, title: "Password", placeholder: "Enter a password", isSecureFiled: true, showError: showPassword, validationIcon: password == confirmPassword && !password.isEmpty ? Image(systemName: "checkmark.circle.fill") : nil)
                    if !passwordErrors.isEmpty {
                        
                        ForEach(passwordErrors, id: \.self) { error in
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)}
                    }
                    
                    InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your Password", isSecureFiled: true, showError: showConfirmPassword, validationIcon: password == confirmPassword && !password.isEmpty ? Image(systemName: "checkmark.circle.fill") : nil)
                    if !passwordMatch {
                        
                        Text("Passwords dont match...")
                            .foregroundColor(.red)
                    }
                    
                    InputView(text: $phoneNumber, title: "Phone Number ", placeholder: "123 469 7890", showError: showPhoneNumber)
                    if !phoneNumberErrors.isEmpty {
                        
                        ForEach(phoneNumberErrors, id: \.self) { error in
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    DatePicker(
                        "Birthday",
                        selection: $birthday,
                        displayedComponents: .date
                    )
                    .foregroundColor(Color(.darkGray))
                    .fontWeight(.semibold)
                    .font(.footnote)
                    
                    InputView(text: $address1, title: "Address Line 1 ", placeholder: "100 Borad St.", showError: showAddress1)
                    
                    InputView(text: $address2, title: "Address Line 2", placeholder: "e.g. Apt 3")
                    
                    InputView(text: $city, title: "City ", placeholder: "New York City", showError: showCity)

                    InputView(text: $state, title: "State", placeholder: "NY", showError: showState)
                    if !stateErrors.isEmpty {
                        
                        ForEach(stateErrors, id: \.self) { error in
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    InputView(text: $zipCode, title: "Zip Code", placeholder: "07285", showError: showZip)
                    if !zipCodeErrors.isEmpty {
                        
                        ForEach(zipCodeErrors, id: \.self) { error in
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    Text("Select profile image")
                        .foregroundColor(Color(.darkGray))
                        .fontWeight(.semibold)
                        .font(.footnote)                    //profile pic
                    PhotosPicker(selection: $photosPickerItem, matching: .images) {
                        Image(uiImage: profileImage ?? UIImage(resource: .golfLogo))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(.circle)
                    }
                    .onChange(of: photosPickerItem) {_, _ in
                        Task {
                            if let photosPickerItem,
                                let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                                if let image = UIImage(data: data) {
                                    profileImage = image
                                }
                            }
                            photosPickerItem = nil
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
            }
            .frame(height: UIScreen.main.bounds.height - 450)            // log in button
            Button {
                firstNameErrors = validateText(text: firstName, validationType: .nonEmpty)
                showFirstName = firstName.isEmpty
                lastNameErrors = validateText(text: lastName, validationType: .nonEmpty)
                showLastName = lastName.isEmpty
                emailErrors = validateText(text: email, validationType: .email)
                showEmail = email.isEmpty
                passwordErrors = validatePassword(password: password)
                showPassword = email.isEmpty || !passwordErrors.isEmpty
                showConfirmPassword = confirmPassword.isEmpty
                passwordMatch = (password == confirmPassword)
                phoneNumberErrors = validatePhoneNumber(phoneNumber: phoneNumber)
                showPhoneNumber = phoneNumber.isEmpty
                showAddress1 = address1.isEmpty
                showCity = city.isEmpty
                stateErrors = validateState(state: state)
                showState = state.isEmpty
                zipCodeErrors = validateZipcode(zipCode: zipCode)
                showZip = zipCode.isEmpty
                
                
                guard firstNameErrors.isEmpty, lastNameErrors.isEmpty, emailErrors.isEmpty, passwordErrors.isEmpty, phoneNumberErrors.isEmpty, zipCodeErrors.isEmpty, stateErrors.isEmpty, !showFirstName, !showLastName, !showEmail, !showPassword, !showConfirmPassword, passwordMatch, !showPhoneNumber, !showAddress1, !showCity, !showState, !showZip else {
                        return
                    }
                
                
                Task {
                    do {
                        try await viewModel.register(withEmail: email, password: password, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, address1: address1, address2: address2, city: city, state: state, zipCode: zipCode, birthday: birthday, profileImage:  profileImage ?? UIImage(resource: .golfLogo))
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
