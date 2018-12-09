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
    var book: BookCell?

    var books = [Book]()

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
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {  [unowned self, ac] _ in
            let titleTextField = ac.textFields![0] as UITextField
            let authorTextField = ac.textFields![1] as UITextField
            
            self.saveNewBook(title: titleTextField.text!, author: authorTextField.text!, genre: Genre(rawValue: self.genreType!)!)
        }
        
        // Don't need '[unowned self, ac] here like in "saveAction" because
        // 'self' and 'ac' are not used in the closure
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            _ in
            
        }
        
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
    
    func saveNewBook(title: String, author: String, genre: Genre) {
        let newBook = Book(title: title, author: author, genre: Genre(rawValue: genre.rawValue)!)
        
        books.append(newBook)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Book", for: indexPath) as! BookCell

        cell.titleLabel.text = books[indexPath.row].title
        cell.authorLabel.text = books[indexPath.row].author

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // remove row from array; reload data OR use a pop-up to delete!!!
        }
    }
}
