//
//  DevelopersTableViewController.swift
//  hs-mobile-chat-app
//
//  Created by Matheus Ruschel on 5/22/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit

class DevelopersTableViewController: UITableViewController {
    @IBOutlet weak var imageViewLeo: UIImageView!
    
    @IBOutlet weak var imageViewMatheus: UIImageView!

    @IBOutlet weak var imageViewVictor: UIImageView!
    
    @IBOutlet weak var leoButton: UIButton!
    
    @IBOutlet weak var mattButton: UIButton!
    
    @IBOutlet weak var victorButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageViewMatheus.layer.cornerRadius = self.imageViewMatheus.frame.size.width / 2
        self.imageViewMatheus.clipsToBounds = true
        self.imageViewMatheus.layer.borderWidth = 3.0
        self.imageViewMatheus.layer.borderColor = UIColor.hsGrayColor().CGColor
        
        self.imageViewLeo.layer.cornerRadius = self.imageViewLeo.frame.size.width / 2
        self.imageViewLeo.clipsToBounds = true
        self.imageViewLeo.layer.borderWidth = 3.0
        self.imageViewLeo.layer.borderColor = UIColor.hsGrayColor().CGColor

        
        self.imageViewVictor.layer.cornerRadius = self.imageViewVictor.frame.size.width / 2
        self.imageViewVictor.clipsToBounds = true
        self.imageViewVictor.layer.borderWidth = 3.0
        self.imageViewVictor.layer.borderColor = UIColor.hsGrayColor().CGColor

        
        mattButton.layer.cornerRadius = 10
        mattButton.clipsToBounds = true
        victorButton.layer.cornerRadius = 10
        victorButton.clipsToBounds = true
        leoButton.layer.cornerRadius = 10
        leoButton.clipsToBounds = true
        
        let buttonLeft = UIBarButtonItem(title: "✘", style: .Done, target: self, action: #selector(cancelButtonClicked))
        self.navigationItem.leftBarButtonItem = buttonLeft
        self.title = "Developers"
    }
    
    func cancelButtonClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    @IBAction func leoButtonClicked(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string:"https://br.linkedin.com/in/leonardodeleon")!)
        
    }
    
    @IBAction func mattButtonClicked(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string:"https://ca.linkedin.com/in/matheus-ruschel-27711026")!)
    }
    
    @IBAction func victorButtonClicked(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string:"https://www.linkedin.com/in/victor-cotrim-92086237")!)
        
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
