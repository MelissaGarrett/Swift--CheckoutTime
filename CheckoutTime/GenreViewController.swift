//
//  ViewController.swift
//  CheckoutTime
//
//  Created by Melissa  Garrett on 11/12/18.
//  Copyright © 2018 MelissaGarrett. All rights reserved.
//

import UIKit
import UserNotifications

class GenreViewController: UITableViewController {
    
    @IBOutlet var genreLabel: UILabel!
    
    var genres = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "CHECKOUT TIME"
        
        scheduleLocalNotification()
        
        // Get Genres and place in an array
        for value in Genre.allCases {
            genres.append(value)
        }
        
        // To remove empty cells from table
        tableView.tableFooterView = UIView()
    }
    
    // Setup location for the 1st day of every month
    func scheduleLocalNotification() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "It's Checkout Time!"
        content.body = "It's time to checkout a book from the local library."
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.day = 01
        dateComponents.hour = 11
        dateComponents.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        center.removeAllPendingNotificationRequests()
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
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

