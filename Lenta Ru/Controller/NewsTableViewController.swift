//
//  NewsTableViewController.swift
//  Lenta Ru
//
//  Created by Pavel Salkevich on 04.11.16.
//  Copyright © 2016 Pavel Salkevich. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    var NewsArray1 = [News]()
    var result = Array<News>()

    override func viewDidLoad() {
        super.viewDidLoad()
        let service = ServiceViewController()

        service.asynchronousWorkLoading { (inner: @escaping () throws -> [News]) -> Void in
            DispatchQueue.main.async{
                do {
                    let result = try inner()
                        print("-----------------------------")
                        print("Finish Loading With Success!")
                        print("Categories count:\(result.count)")
                        print("-----------------------------")
                    self.tableView?.reloadData()
                } catch let error {
                        print(error)
                }
            }
                    self.NewsArray1 = service.NewsArray
                    self.result = service.result1
//                        print("Result:\(self.result)")
        }

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.result.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let newsObj = result[indexPath.row]
            cell.textLabel?.text = newsObj.title
            cell.detailTextLabel?.text = newsObj.rightcol
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
