//
//  DetailViewController.swift
//  rahberapp
//
//  Created by Chinnu M V on 26/04/2024.
//

import Foundation
import UIKit
class DetailViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    var id: Int = 0
    var courseService: CourseService?
    var chapterService: ChapterService?
    var selectedCourse: Course?
    var chapterList: [Chapter] = []
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tutorLabel: UILabel!
    @IBOutlet weak var feesLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var enrollButton: UIButton!
    @IBOutlet weak var chapterListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseService = MockCourseService()
        chapterService = MockChapterService()
        
        // Set the data source and delegate for the table view
        chapterListTableView.dataSource = self
        chapterListTableView.delegate = self
        chapterListTableView.register(ChapterTableViewCell.self, forCellReuseIdentifier: "cellidentifier")
       
        // Fetch course details from the course service based on course iD
        if let data = courseService?.getCoursesWithID(forID:  id) {
            print("Found object with ID 2: \(data)")
            titleLabel.text = data.name
            descriptionLabel.text = data.description
            tutorLabel.text = data.tutor
            durationLabel.text = "Duraton: \(data.duration)"
            feesLabel.text = "Fees: \(data.fees) GBP"
            courseImage.image = UIImage(named: data.courseImage)
        } else {
            
        }
        
        // Fetch all chapters  from the chapter service based on course iD
        if let data = chapterService?.getChaptersWithID(forID:  id) {
            chapterList = data;
        } else {
            
        }
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellidentifierchapter", for: indexPath) as! ChapterTableViewCell
        let item = chapterList[indexPath.row]
        cell.titleLabel?.text = item.name
        cell.subtitleLabel?.text = item.duration
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLogin")
        if(isLoggedIn){
            if let decodedData = UserDefaults.standard.data(forKey: "enrolledCourses") {
                // Convert the data back to array
                if let decodedArray = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedData) as? [Int] {
                    var myArray = decodedArray
                    if myArray.contains(id) {
                        
                    } else {
                        showAlertview(message: "Please login and enroll the course")
                    }
                }
            }
        }
        else
        {
            showAlertview(message: "Please login and enroll the course")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // MARK: - @IBAction Methods
    
    // Method for back button
    @IBAction func backPressed(_ sender: Any) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    // Method for enroll feature
    @IBAction func enrollPressed(_ sender: Any) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLogin")
        if(isLoggedIn){
            if let decodedData = UserDefaults.standard.data(forKey: "enrolledCourses") {
                //  checking user is already enrolled the course and set user defailt
                if let decodedArray = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedData) as? [Int] {
                    var myArray = decodedArray
                    myArray.append(id)
                    if let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: myArray, requiringSecureCoding: false) {
                        // Save the data to UserDefaults
                        UserDefaults.standard.set(encodedData, forKey: "enrolledCourses")
                    }
                }
            }
            else{
                let myArray = [id]
                if let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: myArray, requiringSecureCoding: false) {
                    // Save the data to UserDefaults
                    UserDefaults.standard.set(encodedData, forKey: "enrolledCourses")
                }
            }
            showAlertview(message: "Successfully enrolled the course")
        }
        
        else
        {
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            // If you need to pass data to the destination view controller, you can do so here
            let destinationVC = segue.destination as! LoginViewController
            
        }
    }
    
    // This function to show the message
    func showAlertview(message : String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
