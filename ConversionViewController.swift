//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Graham Strong on 1/31/17.
//  Copyright © 2017 Strong. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet var celsiusLable: UILabel!
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet{
            updateCelsiusLable()
        }
    }
    @IBOutlet var textField: UITextField!
    
    var celsiusValue: Measurement<UnitTemperature>?{
        if let fahrenheitValue = fahrenheitValue{
            return fahrenheitValue.converted(to: .celsius)
        }else {
            return nil
        }
    }
    
    func updateCelsiusLable(){
        if let celsiusValue = celsiusValue{
            celsiusLable.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        }else {
            celsiusLable.text = "???"
        }
    }
    
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
        if let text = textField.text, let value = Double(text){
            fahrenheitValue = Measurement(value: value,unit: .fahrenheit)
        }else {
            fahrenheitValue = nil
        }
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        
        updateCelsiusLable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let hour = NSCalendar.current.component(.hour, from: NSDate() as Date)
        
        let morning = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
        let midDay = UIColor(red: 200/255, green: 200/255, blue: 255/255, alpha: 1.0)
        let Evening = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
        
        switch hour {
        case 6..<11: view.backgroundColor = morning
            break
        case 12..<18: view.backgroundColor = midDay
            break
        case 18..<24: view.backgroundColor = Evening
            break
        default: view.backgroundColor = midDay
        }
        
    }

    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange, replacementString string: String)-> Bool{
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
 /*
        let charactersNotAllowed = NSCharacterSet.letters
        let replacementTextHasLetter = string.rangeOfCharacter(from: charactersNotAllowed)
        
       if replacementTextHasLetter != nil{
            for i in strlen(replacementTextHasLetter) {
                replacementTextHasLetter.remove(at: i)
            }
        }
 , replacementTextHasLetter != nil */
        if existingTextHasDecimalSeparator  != nil,
            replacementTextHasDecimalSeparator != nil{
            return false
        }else{
            return true
        }
    }

}
