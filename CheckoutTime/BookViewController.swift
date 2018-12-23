//
//  BookViewController.swift
//  CheckoutTime
//
//  Created by Melissa  Garrett on 11/12/18.
//  Copyright © 2018 MelissaGarrett. All rights reserved.
//

import UIKit

class BookViewController: UITableViewController {
    var genreType: String!

    var books = [Book]()
    var booksByGenre = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
  
        title = genreType

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewBook))
        
        // Load data from storage
        let defaults = UserDefaults.standard
        
        if let savedData = defaults.object(forKey: "books") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                books = try jsonDecoder.decode([Book].self, from: savedData)
            } catch {
                let ac = UIAlertController(title: "Error", message: "Could not save data.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                
                ac.addAction(action)
                
                present(ac, animated: true)
            }
        }
        
        getBooksByGenre()
    }
    
    // Get books for genre currently displayed
    func getBooksByGenre() {
        for book in books {
            if book.genre.rawValue == genreType {
                booksByGenre.append(book)
            }
        }
    }
    
    @objc func addNewBook() {
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
    
    func saveNewBook(title: String, author: String, genre: Genre) {
        let newBook = Book(title: title, author: author, genre: Genre(rawValue: genre.rawValue)!)
        
        // Save to arrays
        booksByGenre.append(newBook)
        books.append(newBook)
        
        saveDataToStorage()
        
        tableView.reloadData()
    }
    
    func saveDataToStorage() {
        do {
            let defaults = UserDefaults.standard
            let jsonEncoder = JSONEncoder()
            let savedData = try jsonEncoder.encode(books)
            
            defaults.set(savedData, forKey: "books")
        } catch {
            let ac = UIAlertController(title: "Error", message: "Could not save data.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            
            ac.addAction(action)
            
            present(ac, animated: true)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksByGenre.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Book", for: indexPath) as! BookCell
        
        cell.titleLabel?.adjustsFontSizeToFitWidth = true
        cell.titleLabel?.text = booksByGenre[indexPath.row].title
        
        cell.authorLabel?.adjustsFontSizeToFitWidth = true
        cell.authorLabel?.text = booksByGenre[indexPath.row].author
        
        cell.backgroundColor = getBackgroundColor()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            booksByGenre.remove(at: indexPath.row)

            let cell = tableView.cellForRow(at: indexPath) as! BookCell
            let title = cell.titleLabel.text
            let author = cell.authorLabel.text
            
            for book in books {
                if book.title == title && book.author == author {
                    books.removeAll(where: { $0 == book })
                }
            }
            
            saveDataToStorage()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    func getBackgroundColor() -> UIColor {
        switch genreType {
        case Genre.Financial.rawValue: // green
            return UIColor(red: 200/255, green: 255/255, blue: 185/255, alpha: 1.0)
            
        case Genre.Inspirational.rawValue: // blue
            return UIColor(red: 190/255, green: 242/255, blue: 255/255, alpha: 1.0)
            
        case Genre.Fictional.rawValue: // purple
            return UIColor(red: 255/255, green: 203/255, blue: 255/255, alpha: 1.0)
            
        case Genre.NonFictional.rawValue: // yellow
            return UIColor(red: 244/255, green: 254/255, blue: 177/255, alpha: 1.0)
            
        case Genre.AutoBiographical.rawValue: // orange
            return UIColor(red: 255/255, green: 224/255, blue: 135/255, alpha: 1.0)
            
        case .none:
            return UIColor.white
            
        case .some(_):
            return UIColor.white
        }
    }
}
