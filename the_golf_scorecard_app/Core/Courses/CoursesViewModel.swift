//
//  CoursesViewModel.swift
//  the_golf_scorecard_app
//
//  Created by Casey tirrell on 3/11/24.
//

import Foundation
import Firebase
import FirebaseAuth
import UIKit

class CoursesViewModel: ObservableObject {
    @Published var courses: [Course] = []
    @Published var userSession: FirebaseAuth.User?
    @Published var courseImage: UIImage?
    let boundary: String = "Boundry-\(UUID().uuidString)"
    
    func endpointString(endpoint: String) -> String {
        let backendURL = ProcessInfo.processInfo.environment["DATABASEURL"]!
        return  backendURL + endpoint
    }
    
    func fetchCourses() async throws {
        print("Fetching Courses... ")
        guard let user = Auth.auth().currentUser else { return }
        
        let userToken = try? await user.getIDTokenResult(forcingRefresh: true)
        let url = URL(string: self.endpointString(endpoint: "api/v1/courses/all_courses/"))!
        print (self.endpointString(endpoint: "api/v1/courses/all_courses/"))
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer " + (userToken!.token), forHTTPHeaderField: "authorization")
        urlRequest.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        print(String(data: data, encoding: .utf8))
        do {
            let decodedCourses = try JSONDecoder().decode([Course].self, from: data)
            DispatchQueue.main.async {
                self.courses = decodedCourses
            }
        } 
        catch {
            print(error)
            throw error
        }
    }
    
    func loadCourseImage() async throws {
        guard let user = Auth.auth().currentUser else { return }
        let userToken = try? await user.getIDTokenResult(forcingRefresh: true)
        let url = URL(string: self.endpointString(endpoint: "api/v1/users/profile_picture"))!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer " + (userToken!.token), forHTTPHeaderField: "authorization")
        urlRequest.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        courseImage = UIImage(data: data)
    
    }
}

