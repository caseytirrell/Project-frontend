//
//  User.swift
//  the_golf_scorecard_app
//
//  Created by user254089 on 3/4/24.
//

import Foundation
import SwiftUI

struct User: Identifiable, Decodable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let address1: String
    let address2: String
    let city: String
    let state: String
    let zipCode: String
    let profileImage: String
    
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
    static var MOCK_USER = User(id: NSUUID().uuidString, firstName: "Siva Anand", lastName: "Sivakumar", email:"ss546@njit.edu", phoneNumber: "2675676907", address1: "100 Summit St.", address2: "Apt 4", city: "Newark", state: "NJ", zipCode: "08790", profileImage: "")
}
