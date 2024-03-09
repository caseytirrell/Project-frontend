//
//  AuthViewModel.swift
//  the_golf_scorecard_app
//
//  Created by user254089 on 3/4/24.
//

import Foundation
import Firebase
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var errorMessage: String?
    @Published var email: String?
    @Published var photoURL: String?
    @Published var isAuthenticated = false
    let boundary: String = "Boundry-\(UUID().uuidString)"
    init() {
            self.userSession = Auth.auth().currentUser
        }
    
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
    
    
    func endpointString(endpoint: String) -> String {
        let backendURL = ProcessInfo.processInfo.environment["DATABASEURL"]!
        return  backendURL + endpoint
    }
    

    
    func sendBackendUserRegistrationRequest(httpBody: Data) {
        guard let user = Auth.auth().currentUser else { return }
        user.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print("Error fetching ID Token: \(error.localizedDescription)")
                return
            }
            let url = URL(string: self.endpointString(endpoint: "api/v1/users/register"))
            print(url?.absoluteString)
            var urlRequest = URLRequest(url: url!)
            urlRequest.setValue("Bearer " + idToken!, forHTTPHeaderField: "authorization")
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("multipart/form-data; boundary=" + "Boundary-\(UUID().uuidString)", forHTTPHeaderField: "Content")
            urlRequest.httpBody = httpBody
            URLSession.shared.dataTask(with: urlRequest) { data, resp, error in
                 if let error = error {
                     print(error)
                     return
                 }
                 
                 print("success")
             }.resume()
            return
        }
    }
    
    func register(withEmail email: String, password: String, firstName: String, lastName:String, phoneNumber: String, address1: String, address2: String, city: String, state: String, zipCode: String, birthday: String, profileImage: UIImage) async throws {
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
                    
            let lineBreak = "\r\n"
            var requestBody = Data()
            
            requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
            requestBody.append("Content-Disposition: form-data; name=\"first_name\"\(lineBreak + lineBreak)".data(using: .utf8)!)
            requestBody.append("\(firstName + lineBreak)".data(using: .utf8)!)

            requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
            requestBody.append("Content-Disposition: form-data; name=\"last_name\"\(lineBreak + lineBreak)".data(using: .utf8)!)
            requestBody.append("\(lastName + lineBreak)".data(using: .utf8)!)
            
            requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
            requestBody.append("Content-Disposition: form-data; name=\"email\"\(lineBreak + lineBreak)".data(using: .utf8)!)
            requestBody.append("\(email + lineBreak)".data(using: .utf8)!)

            requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
            requestBody.append("Content-Disposition: form-data; name=\"password\"\(lineBreak + lineBreak)".data(using: .utf8)!)
            requestBody.append("\(password + lineBreak)".data(using: .utf8)!)

            requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
            requestBody.append("Content-Disposition: form-data; name=\"phone_number\"\(lineBreak + lineBreak)".data(using: .utf8)!)
            requestBody.append("\(phoneNumber + lineBreak)".data(using: .utf8)!)

            requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
            requestBody.append("Content-Disposition: form-data; name=\"birth_day\"\(lineBreak + lineBreak)".data(using: .utf8)!)
            requestBody.append("\(birthday + lineBreak)".data(using: .utf8)!)

            requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
            requestBody.append("Content-Disposition: form-data; name=\"address_line_1\"\(lineBreak + lineBreak)".data(using: .utf8)!)
            requestBody.append("\(address1 + lineBreak)".data(using: .utf8)!)

            requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
            requestBody.append("Content-Disposition: form-data; name=\"address_line_2\"\(lineBreak + lineBreak)".data(using: .utf8)!)
            requestBody.append("\(address2 + lineBreak)".data(using: .utf8)!)

            requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
            requestBody.append("Content-Disposition: form-data; name=\"city\"\(lineBreak + lineBreak)".data(using: .utf8)!)
            requestBody.append("\(city + lineBreak)".data(using: .utf8)!)

            requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
            requestBody.append("Content-Disposition: form-data; name=\"state\"\(lineBreak + lineBreak)".data(using: .utf8)!)
            requestBody.append("\(state + lineBreak)".data(using: .utf8)!)
            
            requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
            requestBody.append("Content-Disposition: form-data; name=\"zip_code\"\(lineBreak + lineBreak)".data(using: .utf8)!)
            requestBody.append("\(zipCode + lineBreak)".data(using: .utf8)!)
            
            requestBody.append("Content-Disposition: form-data; name=\"profile_picture\"; filename=\"profile_image.jpg\"\(lineBreak)" .data(using: .utf8)!)
            requestBody.append("Content-Type: image/jpeg\(lineBreak + lineBreak)" .data(using: .utf8)!)
            requestBody.append(profileImage.jpegData(compressionQuality: 0.99)!)
            requestBody.append("\(lineBreak)--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
            
            sendBackendUserRegistrationRequest(httpBody: requestBody)
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

