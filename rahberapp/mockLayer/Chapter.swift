//
//  Chapter.swift
//  rahberapp
//
//  Created by Chinnu M V on 26/04/2024.
//

import Foundation
class Chapter {
    // Properties
    var id: Int
    var name: String
    var link: String
    var duration: String
    var courseID: Int
     
    
    
    // Initializer
    init(id: Int, name: String , link: String, duration: String, courseID: Int) {
        self.id = id
        self.name = name
        self.link = link
        self.duration = duration
        self.courseID = courseID
    }
}
