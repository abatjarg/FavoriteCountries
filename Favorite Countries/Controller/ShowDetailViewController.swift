//
//  ShowDetailViewController.swift
//  Favorite Countries
//
//  Created by AJ Batja on 4/7/21.
//

import UIKit

class ShowDetailViewController: UIViewController {
    
    // Country label for the country name
    @IBOutlet weak var countryLabel: UILabel!
    // Favorite things text view for the user's favorite things about the country
    @IBOutlet weak var favoriteThingsTextView: UITextView!
    
    let data: DataStore = DataStore.shared
    
    // When the country gets set, call configureDetails
    var country: Country? {
      didSet {
        configureDetails()
      }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the text box delegate
        favoriteThingsTextView.delegate = self
        
        navigationItem.title = country?.name
        
        // Calling configureDetails to setup the details
        configureDetails()
    }
    
    // Function to setup the details of the view
    func configureDetails() {
        if let country = country, let countryLabel = countryLabel {
            countryLabel.text = country.name
        }
    }

    // Gets called when add button is pressed
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard var country = country else {
            return
        }
        
        // Set the favorite details of the country
        country.favoriteDetails = favoriteThingsTextView.text
        // Add the country to favorite country array
        data.addCountry(country)
        // Dismiss back to root view controller
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

extension ShowDetailViewController: UITextViewDelegate {
    
    // Remove placeholder text and change text color from gray to black
    func textViewDidBeginEditing(_ textView: UITextView) {
        favoriteThingsTextView.text = ""
        favoriteThingsTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
