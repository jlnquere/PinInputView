//
//  ViewController.swift
//  PinInputView
//
//  Created by juli1quere on 01/12/2018.
//  Copyright (c) 2018 juli1quere. All rights reserved.
//

import UIKit
import PinInputView
class ViewController: UIViewController {
    
    @IBOutlet weak var digitsCountLabel: UILabel!
    @IBOutlet weak var digitsCountStepper: UIStepper!

    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var fontSizeStepper: UIStepper!

    @IBOutlet weak var pinInput: PinInput!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.digitsCountStepper.value = Double(self.pinInput.length)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateDigitsCount()
        updateFontSize()
    }
    
    func updateDigitsCount() {
        pinInput.length = Int(digitsCountStepper.value)
        self.digitsCountLabel.text = "\(pinInput.length) digits"
    }
    
    func updateFontSize() {
        
        pinInput.font = UIFont.systemFont(ofSize: CGFloat(fontSizeStepper.value))
        
        self.fontSizeLabel.text = "Font size: \(fontSizeStepper.value)"
    }

    @IBAction func digitsStepperValueChanged(_ sender: Any) {
        updateDigitsCount()
    }
    
    @IBAction func fontSizeStepperValueChanged(_ sender: Any) {
        updateFontSize()
    }
}

