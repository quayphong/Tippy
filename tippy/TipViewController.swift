//
//  ViewController.swift
//  tippy
//
//  Created by user on 14/2/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var britishTotalLabel: UILabel!
    @IBOutlet weak var euroTotalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        let bill = Double(billField.text!) ?? 0
        updateTipAndTotal(bill)
        
        // Remember billing amount and last access date
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(bill, forKey: "PreviousAmount")
        userDefaults.setValue(Date.timeIntervalSinceReferenceDate, forKey: "LastUpdated")
        userDefaults.synchronize()
    }
    
    func updateTipAndTotal(_ bill: Double)
    {
        let tipPercentages = [0.18, 0.2, 0.25]
    
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
    
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
    
        formatter.locale = Locale(identifier: "en_US")
        tipLabel.text = formatter.string(from: tip as NSNumber)
    
        formatter.locale = Locale(identifier: "en_US")
        totalLabel.text = formatter.string(from: total as NSNumber)
    
        formatter.locale = Locale(identifier: "en_UK")
        britishTotalLabel.text = formatter.string(from: total as NSNumber)
    
        formatter.locale = Locale(identifier: "es_ES")
        euroTotalLabel.text = formatter.string(from: total as NSNumber)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        tipControl.selectedSegmentIndex = defaultTipIndex

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animate billing amount and tip percentages
        self.billField.alpha = 0
        self.tipControl.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {
            self.billField.alpha = 1
            self.tipControl.alpha = 1
        })
        
        // Load previous billing amount
        let userDefault = UserDefaults.standard
        let previousAmount = userDefault.double(forKey: "PreviousAmount")
        let nowDate = Date.timeIntervalSinceReferenceDate
        let lastUpdated = userDefault.double(forKey: "LastUpdated")
        let isValidTime = (nowDate - lastUpdated) < (10*60)
        if (previousAmount != 0 && isValidTime){
            billField.text = String(format:"%.0f", previousAmount)
            updateTipAndTotal(previousAmount)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
}

