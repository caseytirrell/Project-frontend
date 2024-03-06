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
                self.userSession = result.user
                self.email = result.user.email
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
    
    func fetchIDTokenAndSendUserData() {
        guard let user = Auth.auth().currentUser else { return }
        user.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print("Error fetching ID Token: \(error.localizedDescription)")
                return
            }
            
            guard let IDToken = idToken else { return }
            let userData = ["email": user.email, "uid": user.uid]
        
            self.sendUserDataToBackend(userData: userData, idToken: IDToken)
        }
    }
    
    func sendUserDataToBackend(userData: [String: Any?], idToken: String) {
        //Not Sure what the correct api ending
        let urlString = "https://localhost:5005/api-docs/userData/.../"
        guard let url =  URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let JSONData = try JSONSerialization.data(withJSONObject: userData, options: [])
            urlRequest.httpBody = JSONData
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print("Error sending user data to backend: \(error.localizedDescription)")
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("User data and ID token successfully sent backend.")
                }
                else {
                    print("Server side error/unexpected status code")
                }
            }
            task.resume()
        }
        catch {
            print("Error serializing user data: \(error.localizedDescription)")
            return
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
