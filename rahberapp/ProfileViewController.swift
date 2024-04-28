//
//  ProfileViewController.swift
//  rahberapp
//
//  Created by Chinnu M V on 27/04/2024.
//


import Foundation
import UIKit
class ProfileViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    var coursesList: [Course] = []
    var courseService: CourseService?
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var courseListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseService = MockCourseService()
        courseListTableView.dataSource = self
        courseListTableView.delegate = self
        courseListTableView.register(CourseTableViewCell.self, forCellReuseIdentifier: "cellIdentifier1")
        
        if let username = UserDefaults.standard.string(forKey: "loginName") {
            print("Username: \(username)")
            nameLabel.text = username
        }
        if let email = UserDefaults.standard.string(forKey: "loginEmail") {
            print("Username: \(email)")
            emailLabel.text = email
        }
        //  Rereiving all enrolled courses for tyhe user
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLogin")
        if(isLoggedIn){
            if let decodedData = UserDefaults.standard.data(forKey: "enrolledCourses") {
                // Convert the data back to array
                if let decodedArray = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedData) as? [Int] {
                    var myArray = decodedArray
                    for id in myArray {
                        //  Rereiving all enrolled courses for tyhe user
                        if let data = courseService?.getCoursesWithID(forID:  id) {
                            coursesList.append(data)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseTableViewCell", for: indexPath) as! CourseTableViewCell
        let item = coursesList[indexPath.row]
        cell.titleLabel?.text = item.name
        cell.subtitleLabel?.text = item.duration
        cell.iconImageView?.image = UIImage(named: item.courseImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = coursesList[indexPath.item]
        print("Selected item: \(selectedItem)")
        performSegue(withIdentifier: "detailProfileviewSegue", sender: selectedItem.id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailProfileviewSegue" {
            // If you need to pass data to the destination view controller, you can do so here
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.id = sender as! Int
        }
    }
    
    // MARK: - @IBAction Methods
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        dismiss(animated: true)
    }
}
