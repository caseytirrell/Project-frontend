//
//  User.swift
//  the_golf_scorecard_app
//
//  Created by user254089 on 3/4/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: firstName + lastName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
    
    var fullName: String {
        return firstName + " " + lastName
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, firstName: "Siva Anand", lastName: "Sivakumar", email:"ss546@njit.edu")
}
