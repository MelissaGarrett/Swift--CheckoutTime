//
//  ViewController.swift
//  CheckoutTime
//
//  Created by Melissa  Garrett on 11/12/18.
//  Copyright © 2018 MelissaGarrett. All rights reserved.
//

import UIKit

class GenreViewController: UITableViewController {
    
    @IBOutlet var genreLabel: UILabel!
    
    var books = [Book]()
    var genres = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "CHECKOUT TIME"
                
        // Get Genres and place in an array
        for value in Genre.allCases {
            genres.append(value)
        }
        
        // To remove empty cells from table
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Genre.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath)
        
        cell.textLabel?.text = genres[indexPath.row].rawValue
        
        return cell
    }
    
    // Need to pass value of selected cell to 2nd VC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "bookVC") as? BookViewController {
            vc.genreType = genres[indexPath.row].rawValue
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

