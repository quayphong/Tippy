//
//  SettingsViewController.swift
//  tippy
//
//  Created by user on 14/2/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var tipPicker: UIPickerView!
    
    let tipPercentages = ["18%", "20%","25%"]
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tipPercentages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipPercentages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        var currentTip = 0.18
        switch row {
        case 1:
            currentTip = 0.2
        case 2:
            currentTip = 0.25
        default:
            currentTip = 0.18
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(currentTip, forKey: "DefaultTip")
        userDefaults.synchronize()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let userDefault = UserDefaults.standard
        let defaultTipValue = userDefault.double(forKey: "DefaultTip")
        var defaultTipIndex = 0
        
        switch defaultTipValue {
        case 0.2:
            defaultTipIndex = 1
        case 0.25:
            defaultTipIndex = 2
        default:
            defaultTipIndex = 0
        }
        
        tipPicker.selectRow(defaultTipIndex, inComponent: 0, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
