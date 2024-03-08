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
    
    init() {
            self.userSession = Auth.auth().currentUser
        }
    
    func logIn(withEmail email: String, password: String) async throws {
        print("Logging in user ...")
        print(ProcessInfo.processInfo.environment["DATABASEURL"])
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
        
            Task {
                await self.sendUserDataToBackend(userData: userData)
            }
        }
    }
    
    func sendUserDataToBackend(userData: [String: Any?]) async {
        //Not sure how to 
        let urlString = "https://localhost:5005/api/v1/users/register"
        guard let url =  URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let JSONData = try JSONSerialization.data(withJSONObject: userData, options: [])
            urlRequest.httpBody = JSONData
            
            let (_, response) = try await URLSession.shared.upload(for: urlRequest, from: JSONData)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                
                print("Server error or unexpected status code")
                return
            }
            print("User data successfulyl sent to backend.")
        }
        catch {
            print("Error serializing user data: \(error.localizedDescription)")
            return
        }
    }
    
    func register(withEmail email: String, password: String, firstName: String, lastName:String, phoneNumber: String, address1: String, address2: String, city: String, state: String, zipCode: String, birthday: String) async throws {
        print("Registering user ... ")
        do {
            
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = authResult.user
            
            let userData: [String: Any] = [
                
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "password": password,
                "phoneNumber": phoneNumber,
                "birthday": birthday,
                "address1": address1,
                "address2": address2,
                "city": city,
                "state": state,
                "zipCode": zipCode
            ]
            
            await sendUserDataToBackend(userData: userData)
        }
        catch let error {
            DispatchQueue.main.async {
                
                self.errorMessage = error.localizedDescription
            }
            throw error
        }
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
                self.errorMessage = "Error signing out: \(signOutError.localizedDescription)"
            }
        }
    }
}
