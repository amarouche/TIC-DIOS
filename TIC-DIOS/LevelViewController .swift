//
//  Level .swift
//  TIC-DIOS
//
//  Created by Ouahab Koussaila AMAROUCHE on 26/07/2017.
//  Copyright © 2017 Ouahab Koussaila AMAROUCHE. All rights reserved.
//

import UIKit


class LevelViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet var Pseudofield: UITextField!
    @IBOutlet var MyPicker: UIPickerView!
    var niveau = "Facile"
    var wawa = String()
    let LevelArray = ["Facile","Moyen","Difficile"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyPicker.delegate = self
        MyPicker.dataSource = self
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return LevelArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        niveau = LevelArray[row]
        return NSLog("items : \(LevelArray[row])")
    }

    @IBAction func btn(_ sender: Any) {
        wawa = Pseudofield.text!
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let distView  = segue.destination as! ViewGameController
        distView.level = niveau
        let distView2  = segue.destination as! ViewGameController
        distView2.pseu = wawa
    }
}
