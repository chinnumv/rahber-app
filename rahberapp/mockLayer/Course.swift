//
//  Course.swift
//  rahberapp
//
//  Created by Chinnu M V on 26/04/2024.
//

import Foundation
import UIKit
class Course {
    // Properties
    var id: Int
    var name: String
    var description: String
    var fees: Double
    var duration: String
    var courseImage : String
    var tutor : String
    
    // Initializer
    init(id: Int, name: String, description: String, fees: Double, duration: String, courseimage: String, tutor: String) {
        self.id = id
        self.name = name
        self.description = description
        self.fees = fees
        self.duration = duration
        self.tutor = tutor
        self.courseImage = courseimage
    }
}
