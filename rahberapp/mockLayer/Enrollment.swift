//
//  Enrollment.swift
//  rahberapp
//
//  Created by Chinnu M V on 26/04/2024.
//

import Foundation
class Enrollment {
    // Properties
    var id: Int
    var courseID: Int
    var email: String
     
    // Initializer
    init(id: Int, courseID: Int , email: String) {
        self.id = id
        self.courseID = courseID
        self.email = email
    }
}

