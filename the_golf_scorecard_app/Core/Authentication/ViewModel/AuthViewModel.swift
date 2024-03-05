//
//  AuthViewModel.swift
//  the_golf_scorecard_app
//
//  Created by user254089 on 3/4/24.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var errorMessage: String?
    @Published var email: String?
    @Published var photoURL: String?
    @Published var isAuthenticated = false
    
    
    func logIn(withEmail email: String, password: String) async throws {
        print("Logging in user ...")
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            
            DispatchQueue.main.async {
                self.isAuthenticated = true
            }
            print(result.user.uid)
        } 
        catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func register(withEmail email: String, password: String, firstName: String, lastName:String, phoneNumber: String, address1: String, address2: String, city: String, state: String, zipCode: String, birthday: String) async throws {
        print("Registering user ... ")
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.userSession = nil
                self.currentUser = nil
                self.isAuthenticated = false
            }
        }
        catch let signOutError as NSError {
            DispatchQueue.main.async {
                self.errorMessage = "Error signing out: signOutError.localizedDescription)"
                }
            }
        }
}
