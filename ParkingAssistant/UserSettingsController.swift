//
//  UserSettingsController.swift
//  ParkingAssistant
//
//  Created by Nacho Mezzadra on 18/2/15.
//  Copyright (c) 2015 Nacho Mezzadra. All rights reserved.
//

import UIKit
class UserSettingsController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var licensePlateTextField: UITextField!
    @IBOutlet weak var automaticallyDetermineLocationSwitch: UISwitch!
    @IBOutlet weak var fixedLocationLabel: UILabel!
    
    private var userSettings = UserSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        licensePlateTextField.delegate = self
        updateUi()
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action: "back:")
    }
    
    override func viewDidAppear(animated: Bool) {
        updateUi()
    }
    
    func updateUi() {
        userSettings.load()
        automaticallyDetermineLocationSwitch.on = userSettings.automaticallyDetermineLocation
        licensePlateTextField.text = userSettings.licensePlate
        fixedLocationLabel.text = userSettings.lastKnownLocation
    }
    
    @IBAction func saveSettings(sender: AnyObject) {
        self.userSettings.licensePlate = licensePlateTextField.text
        self.userSettings.automaticallyDetermineLocation = automaticallyDetermineLocationSwitch.on
        userSettings.save()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        licensePlateTextField.resignFirstResponder()
        self.view.endEditing(true)
    }

    
    @IBAction func automaticallyDetermineLocationValueChanged(sender: UISwitch) {
        println(sender.on)
        self.userSettings.automaticallyDetermineLocation = sender.on
        println(userSettings.automaticallyDetermineLocation)
    }
    
    @IBAction func licensePlateEditingDidEnd(sender: UITextField) {
        println(sender.text)
        self.userSettings.licensePlate = sender.text
        println(userSettings.licensePlate)
    }
    

    
    // called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}