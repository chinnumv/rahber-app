//
//  ViewController.swift
//  rahberapp
//
//  Created by Chinnu M V on 26/04/2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    var courseService: CourseService?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var courseListTableView: UITableView!
    @IBOutlet weak var courseListCView: UICollectionView!
    @IBOutlet weak var profileButton: UIButton!
    
    var coursesList: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Educate Yourself!"
        descriptionLabel.text = "Education is the key to unlocking your potential.!"
        
        // Set the data source and delegate for the table view
        courseListTableView.dataSource = self
        courseListTableView.delegate = self
        
        // Set the data source and delegate for the collection view
        courseListCView.dataSource = self
        courseListCView.delegate = self
        
        // Create a layout for the collection view with horizontal scrolling
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // Set the scroll direction to horizontal
        courseListCView.collectionViewLayout = layout
        
        // Register the table view cell class  and colliection view cell classfor reuse
        courseListTableView.register(CourseTableViewCell.self, forCellReuseIdentifier: "cellIdentifier1")
        courseListCView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCellIdentifier1")
        
        // Fetch courses from the course service
        courseService = MockCourseService()
        courseService?.getCourses(completion: { result  in
            switch result {
            case .success(let courses):
                self.coursesList = courses;
            case .failure(let error):
                print("Error fetching courses: \(error.localizedDescription)")
            }
            
            
        })
        
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
        
        // Retrieve the course object from the coursesList array based on the current indexPath
        let item = coursesList[indexPath.row]
        
        // Set the title label , subtitle and iconImageView of the cell to the name of the course, duration and image
        cell.titleLabel?.text = item.name
        cell.subtitleLabel?.text = item.duration
        cell.iconImageView?.image = UIImage(named: item.courseImage)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = coursesList[indexPath.item]
        print("Selected item: \(selectedItem)")
        performSegue(withIdentifier: "detailviewSegue", sender: selectedItem.id)
    }
    
    // MARK: - UIcollectionViewDelegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coursesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell1", for: indexPath) as! CustomCollectionViewCell
        let item = coursesList[indexPath.row]
        
        // Set the title label , subtitle and iconImageView of the cell to the name of the course, duration and image
        cell.titleCLabel?.text = item.name
        cell.subtitleCLabel?.text = item.duration
        cell.iconCImageView?.image = UIImage(named: item.courseImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Return the custom size for each item
        let cellWidth = collectionView.bounds.width - 80 // Adjust for cell spacing and insets
        let cellHeight: CGFloat = 250 // Set your desired cell height here
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle item selection here
        
        let selectedItem = coursesList[indexPath.item]
        
        // Perform a segue with the specified identifier to transition to the detail view controller
        performSegue(withIdentifier: "detailviewSegue", sender: selectedItem.id)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailviewSegue" {
            let destinationVC = segue.destination as! DetailViewController
            //Set the id property of the destination view controller to the retrieved id
            destinationVC.id = sender as! Int
        }
    }
    
    // MARK: - @IBAction Methods
    
    @IBAction func profilePressed(_ sender: Any) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLogin")
        if(isLoggedIn){
            performSegue(withIdentifier: "profileSegue", sender: nil)
        }
        else{
            performSegue(withIdentifier: "homeLoginSegue", sender: nil)
            
        }
    }
}

