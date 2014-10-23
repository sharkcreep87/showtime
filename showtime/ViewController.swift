//
//  ViewController.swift
//  showtime
//
//  Created by mohd shafeq on 10/15/14.
//  Copyright (c) 2014 mohd shafeq. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController ,UITableViewDelegate {

   
   
    @IBOutlet var title: UILabel!
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var desc: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // NOT LIVE
        
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let stringDate: String = formatter.stringFromDate(NSDate())
        
        println(stringDate)
        
        let urlPath = "http://live.my.showtimezz.d--buzz.com/\(stringDate)/mys/kul/movies/showtimes.json"
        println(urlPath)
        let url: NSURL = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            println("Task completed")
            if((error) != nil) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            } else {
                
                let results: NSArray = jsonResult["movies"] as NSArray
                for item in results {
                    // we convert each key to a String
                    var name: String = item["title"] as String
                    
                    println(name)
                }
                
            }
            
        })
        task.resume()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

