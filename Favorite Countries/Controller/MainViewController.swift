//
//  ViewController.swift
//  Favorite Countries
//
//  Created by AJ Batja on 4/5/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    let data: DataStore = DataStore.shared
    
    var savedCountries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Sett the main table view data source and delegate
        mainTableView.delegate =  self
        mainTableView.dataSource = self
        
        // Function to refresh the data
        refreshData()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshData()
    }
    
    // Function to refresh the data
    private func refreshData() {
        self.savedCountries = data.savedCountries
        
        // Check is there is saved countries
        if self.savedCountries.isEmpty {
            mainTableView.isHidden = true
        } else {
            mainTableView.isHidden = false
            mainTableView.reloadData()
        }
    }


}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "MainViewControllerTableViewCell", for: indexPath) as! MainViewControllerTableViewCell
        let country = savedCountries[indexPath.row]
        cell.configureCell(country)
        return cell
    }
    
}


