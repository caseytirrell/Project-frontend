//
//  Course.swift
//  the_golf_scorecard_app
//
//  Created by Casey tirrell on 3/11/24.
//

import Foundation
import UIKit

struct Course: Identifiable, Codable {
    let id: String
    let courseName: String
    let imageURI: String
    let phoneNumber: String
    let address1: String
    let address2: String?
    let city: String
    let state: String
    let zipCode: String
    let desc: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case courseName
        case imageURI
        case phoneNumber
        case address1
        case address2
        case city, state
        case zipCode
        case desc
    }
}
