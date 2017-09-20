//
//  ScoreViewController.swift
//  TIC-DIOS
//
//  Created by Ouahab Koussaila AMAROUCHE on 24/07/2017.
//  Copyright © 2017 Ouahab Koussaila AMAROUCHE. All rights reserved.
//

import UIKit
import SwiftyJSON

class ScoreViewController: UIViewController {
    var nbrRow = 0
    var nom = ""
    var Score = ""

    override func viewDidLoad() {
        super.viewDidLoad()
               // Do any additional setup after loading the view, typically from a nib.
        parseJSON()
        
    }
    
    func parseJSON(){
        let path :String = Bundle.main.path(forResource: "JSONScore", ofType: "json") as String!
        let jsonData = NSData(contentsOfFile: path) as NSData!
        let read = JSON(data: jsonData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
      
        nbrRow = read["Players"].count
        NSLog("\(nbrRow)")
        
        for i in 1...nbrRow{
            var user = "user"
            user += "\(i-1)"
            let s: Int = i * 30
            var name = read["Players"][user]["pseudo"]
            var scores = read["Players"][user]["score"]
            nom =  name.stringValue
            Score =  scores.stringValue
            addArray(name: nom,z: s,score: Score)
        }
    }

    func addArray(name: String,z: Int, score: String){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285 + z)
//        label.textAlignment = .center
        label.text = nom + " : " + score
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
