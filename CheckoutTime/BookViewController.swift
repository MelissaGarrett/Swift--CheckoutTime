//
//  BookViewController.swift
//  CheckoutTime
//
//  Created by Melissa  Garrett on 11/12/18.
//  Copyright © 2018 MelissaGarrett. All rights reserved.
//

import UIKit

class BookViewController: UITableViewController {
    var genreType: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let genreType = genreType {
            title = genreType
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBook))
        
        setBackgroundColor()
    }
    
    @objc func addBook() {
        let alertMsg = "Add book for the \(genreType!) genre."
        
        let ac = UIAlertController(title: "", message: alertMsg, preferredStyle: .alert)
        ac.addTextField(configurationHandler: { (textField: UITextField!) -> Void in
            textField.placeholder = "Enter title"
        })
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let bookTitle = ac.textFields![0] as UITextField
            let bookAuthor = ac.textFields![1] as UITextField
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action: UIAlertAction!) -> Void in })
        ac.addTextField(configurationHandler: { (textField: UITextField!) -> Void in
            textField.placeholder = "Enter author"
        })
        
        ac.addAction(saveAction)
        ac.addAction(cancelAction)
        
        self.present(ac, animated: true)
    }
    
    func setBackgroundColor() {
        switch genreType {
        case Genre.Financial.rawValue: // green
            tableView.backgroundColor = UIColor(red: 200/255, green: 255/255, blue: 185/255, alpha: 1.0)
            
        case Genre.Inspirational.rawValue: // blue
            tableView.backgroundColor = UIColor(red: 190/255, green: 242/255, blue: 255/255, alpha: 1.0)
            
        case Genre.Fictional.rawValue: // purple
            tableView.backgroundColor = UIColor(red: 255/255, green: 203/255, blue: 255/255, alpha: 1.0)
            
        case Genre.NonFictional.rawValue: // yellow
            tableView.backgroundColor = UIColor(red: 244/255, green: 254/255, blue: 177/255, alpha: 1.0)
            
        case Genre.AutoBiographical.rawValue: // orange
            tableView.backgroundColor = UIColor(red: 255/255, green: 224/255, blue: 135/255, alpha: 1.0)
            
        case .none:
            tableView.backgroundColor = UIColor.white

        case .some(_):
            tableView.backgroundColor = UIColor.white
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
