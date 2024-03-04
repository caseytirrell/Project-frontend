//
//  AuthViewModel.swift
//  the_golf_scorecard_app
//
//  Created by user254089 on 3/4/24.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    
    func logIn(withEmail email: String, password: String) async throws {
        print("Logging in user ...")
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print(result.user.uid)
        } catch {
            
        }
    }
    
    func register(withEmail email: String, password: String, firstName: String, lastName:String, phoneNumber: String, address1: String, address2: String, city: String, state: String, zipCode: String, birthday: String) async throws {
        print("Registering user ... ")
    }
    
    func signOut() {
        print("Signing out user")
    }
}
