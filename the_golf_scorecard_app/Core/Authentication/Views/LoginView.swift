import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var showEmail = false
    @State private var password = ""
    @State private var showPassword = false
    @State private var emailErrors: [String] = []
    @State private var passwordErrors: [String] = []
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
    
    var body: some View {
        NavigationStack{
            VStack {
                // TODO add logo later
                                Image("golf_logo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 120)
                                    .padding(.vertical, 32)
                                
                                // log in fields
                                VStack(spacing: 24) {
                                    InputView(text: $email, title: "Email Address", placeholder: "yourname@example.com", showError: showEmail)
                                        .autocapitalization(.none)
                                    if !emailErrors.isEmpty {
                                        ForEach(emailErrors, id: \.self) {
                                            error in
                                            Text(error)
                                                .foregroundColor(.red)
                                                .font(.caption)
                                        }
                                    }
                                    
                                    InputView(text: $password, title: "Password", placeholder: "Enter Password", isSecureFiled: true, showError: showPassword)
                                    if !passwordErrors.isEmpty {
                                        ForEach(passwordErrors, id: \.self) {
                                            error in
                                            Text(error)
                                                .foregroundColor(.red)
                                                .font(.caption)
                                        }
                                    }
                                }
                                .padding(.all, 24)
                                // log in button
                                Button {
                                    
                                    showEmail = email.isEmpty
                                    showPassword = password.isEmpty
                                    emailErrors = validateText(text: email, validationType: .email)
                                    passwordErrors = validateText(text: password, validationType: .nonEmpty)
                                    
                                    guard emailErrors.isEmpty, passwordErrors.isEmpty, !showEmail, !showPassword else { return }
                                    
                                    Task {
                                        try await viewModel.logIn(withEmail: email, password: password)
                                    }
                                } label: {
                                    HStack {
                                        Text("LOG IN")
                                            .fontWeight(.semibold)
                                        Image("arrow.right")
                                    }
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width - 32,height: 48)
                                }
                                .background(Color(.systemBlue  ))
                                .cornerRadius(10)
                
                
                Spacer()
                
                // sign up
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 2){
                        Text("Don't have an account yet?")
                        Text("Sign Up").fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
