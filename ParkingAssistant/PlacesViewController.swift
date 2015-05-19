//
//  PlacesViewController.swift
//  ParkingAssistant
//
//  Created by Nacho Mezzadra on 9/3/15.
//  Copyright (c) 2015 Nacho Mezzadra. All rights reserved.
//

import UIKit

class PlacesViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    var placesArray = NSMutableArray()
    
    var previousCheckedIndex = 0
    var userSettings = UserSettings()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.placesArray.addObject("Tandil")
        self.placesArray.addObject("Moron")
        self.placesArray.addObject("La Plata")
        self.placesArray.addObject("Mar del Plata")
        self.placesArray.addObject("Junin")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension

    }

    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placesArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell

        var currentCity = self.placesArray.objectAtIndex(indexPath.row) as? String

        cell.textLabel?.text = currentCity

        // if current city is the one saved, we check it
        if (userSettings.lastKnownLocation == currentCity) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            previousCheckedIndex = indexPath.row
        }

        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if (indexPath.row != previousCheckedIndex) {
            var cell: UITableViewCell = self.tableView.cellForRowAtIndexPath(indexPath)!
            if (cell.accessoryType == UITableViewCellAccessoryType.None) {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                if (previousCheckedIndex != indexPath.row) {
                    cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: previousCheckedIndex, inSection: 0))!
                    cell.accessoryType = UITableViewCellAccessoryType.None
                    previousCheckedIndex = indexPath.row
                }
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }

            if let currentLocation = self.placesArray.objectAtIndex(indexPath.row) as? String {
                userSettings.lastKnownLocation = currentLocation
                userSettings.save()
            }

        
            tableView.reloadData()
        }
    }
}
