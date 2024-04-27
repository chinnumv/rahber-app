//
//  MockPrototype.swift
//  rahberapp
//
//  Created by Chinnu M V on 26/04/2024.
//

import Foundation

protocol UserService {
    func getUser(completion: @escaping (Result<User, Error>) -> Void)
    func getUserWithEmail(forEmail email: String,forPassword password: String)-> User?
}

protocol CourseService {
    func getCourses(completion: @escaping (Result<[Course], Error>) -> Void)
    func getCoursesWithID(forID id: Int)-> Course?
}

protocol ChapterService {
    func getChaptersWithID(forID id: Int)-> [Chapter]?
}

class MockUserService: UserService {
    let mockUsers = [User(id: 1, name: "user1", email: "user1@example.com", password : "1234567"),
                     User(id: 2, name: "user2", email: "user2@example.com", password : "1234567"),
                     User(id: 3, name: "user3", email: "user3@example.com", password : "1234567"),
                     User(id: 4, name: "user4", email: "user4@example.com", password : "1234567"),
                     User(id: 5, name: "user5", email: "user5@example.com", password : "1234567"),
                     User(id: 6, name: "user6", email: "user6@example.com", password : "1234567"),
                     User(id: 7, name: "user7", email: "user7@example.com", password : "1234567"),
    ]
    
    func getUser(completion: @escaping (Result<User, Error>) -> Void) {
        let mockUser = User(id: 1, name: "John Doe", email: "john@example.com", password : "1234567")
        completion(.success(mockUser))
    }
    
    func getUserWithEmail(forEmail email: String,forPassword password: String) -> User? {
        var user: User?
        for object in mockUsers {
            if object.email == email && object.password == password  {
                user = object
            }
        }
        return user
    }
    
}

class MockCourseService: CourseService {
    let mockCourses = [
        Course(id: 1, name: "Software Development", description: "Learn the fundamentals of programming languages such as Python, Java, or JavaScript, and delve into advanced topics like data structures, algorithms, and object-oriented design. Gain hands-on experience in building real-world applications through practical projects and assignments. ", fees: 299.99, duration: "2 months",courseimage: "software",tutor: "James Smith"),
        Course(id: 2, name: "Web Development", description: "From foundational concepts like HTML, CSS, and JavaScript to advanced frameworks like React, Angular, or Vue.js, our course covers the full spectrum of web development technologies", fees: 159.99, duration: "12 weeks",courseimage: "web",tutor: "John Arnold"),
        Course(id: 3, name: "Mobile App Development", description: "Master mobile app development with our comprehensive course. Learn essential skills in iOS and Android development, UI/UX design, and app deployment. Gain hands-on experience building real-world applications and launch your career as a mobile app developer.", fees: 400.00, duration: "3 months",courseimage: "mobile",tutor: "Ann Bella"),
        Course(id: 4, name: "Artificial intelligence", description: "Unlock the potential of AI with our immersive course. Explore cutting-edge techniques in machine learning, neural networks, and natural language processing. Develop AI-powered applications and gain insights into the future of technology.", fees: 599.99, duration: "6 months",courseimage: "ai",tutor: "Joseph Raphael"),
        Course(id: 5, name: "Python Development", description: "Join our Python Development course to become proficient in one of the most versatile programming languages. Master Python fundamentals, data analysis, web development, and automation. Gain practical experience through hands-on projects.", fees: 450.00, duration: "4 months",courseimage: "python",tutor: "Peter Jack"),
        
    ]
    
    func getCourses(completion: @escaping (Result<[Course], Error>) -> Void) {
        completion(.success(mockCourses))
    }
    
    func getCoursesWithID(forID id: Int) -> Course? {
        for object in mockCourses {
            if object.id == id {
                return object
            }
        }
        return nil
    }
}

class MockChapterService: ChapterService {
    let mockChapters = [
        Chapter(id: 1,name: "Introduction",link: "link",duration: "10 min",courseID: 1),
        Chapter(id: 2,name: "Introduction",link: "link",duration: "15 min",courseID: 1),
        Chapter(id: 3,name: "Introduction",link: "link",duration: "20 min",courseID: 1),
        Chapter(id: 4,name: "Introduction",link: "link",duration: "33 min",courseID: 1),
        Chapter(id: 5,name: "Conclusion",link: "link",duration: "27 min",courseID: 1),
        
        Chapter(id: 6,name: "Introduction",link: "link",duration: "10 min",courseID: 2),
        Chapter(id: 7,name: "Introduction",link: "link",duration: "15 min",courseID: 2),
        Chapter(id: 8,name: "Introduction",link: "link",duration: "20 min",courseID: 2),
        Chapter(id: 9,name: "Introduction",link: "link",duration: "33 min",courseID: 2),
        Chapter(id: 10,name: "Conclusion",link: "link",duration: "27 min",courseID: 2),
        
        Chapter(id: 11,name: "Introduction",link: "link",duration: "10 min",courseID: 3),
        Chapter(id: 12,name: "Introduction",link: "link",duration: "15 min",courseID: 3),
        Chapter(id: 13,name: "Introduction",link: "link",duration: "20 min",courseID: 3),
        Chapter(id: 14,name: "Introduction",link: "link",duration: "33 min",courseID: 3),
        Chapter(id: 15,name: "Conclusion",link: "link",duration: "27 min",courseID: 3),
        
        Chapter(id: 16,name: "Introduction",link: "link",duration: "10 min",courseID: 4),
        Chapter(id: 17,name: "Introduction",link: "link",duration: "15 min",courseID: 4),
        Chapter(id: 18,name: "Introduction",link: "link",duration: "20 min",courseID: 4),
        Chapter(id: 19,name: "Introduction",link: "link",duration: "33 min",courseID: 4),
        Chapter(id: 20,name: "Conclusion",link: "link",duration: "27 min",courseID: 4),
        
        Chapter(id: 21,name: "Introduction",link: "link",duration: "10 min",courseID: 5),
        Chapter(id: 22,name: "Introduction",link: "link",duration: "15 min",courseID: 5),
        Chapter(id: 23,name: "Introduction",link: "link",duration: "20 min",courseID: 5),
        Chapter(id: 24,name: "Introduction",link: "link",duration: "33 min",courseID: 5),
        Chapter(id: 25,name: "Conclusion",link: "link",duration: "27 min",courseID: 5),
        ]
    
    func getChaptersWithID(forID id: Int) -> [Chapter]? {
        var coursesList: [Chapter] = []
        // Iterate through the mock data source to find the object with the matching ID
        for object in mockChapters {
            if object.courseID == id {
                coursesList.append(object)
            }
        }
        return coursesList
    }
}
