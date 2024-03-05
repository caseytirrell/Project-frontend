import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
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
                                    InputView(text: $email, title: "Email Address", placeholder: "yourname@example.com")
                                        .autocapitalization(.none)
                                    
                                    InputView(text: $password, title: "Passowrd", placeholder: "Enter Password", isSecureFiled: true)
                                }
                                .padding(.all, 24)
                                // log in button
                                Button {
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