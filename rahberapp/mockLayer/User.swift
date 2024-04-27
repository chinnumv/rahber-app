//
//  User.swift
//  rahberapp
//
//  Created by Chinnu M V on 26/04/2024.
//


import Foundation
class User {
    // Properties
    var id: Int
    var name: String
    var email: String
    var password: String
    
    // Initializer
    init(id: Int, name: String , email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
}

