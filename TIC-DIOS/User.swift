//
//  User.swift
//  TIC-DIOS
//
//  Created by Ouahab Koussaila AMAROUCHE on 26/07/2017.
//  Copyright © 2017 Ouahab Koussaila AMAROUCHE. All rights reserved.
//

import Foundation
import UIKit


class User: NSObject {

    var t :Int = 0
    
func  create_perso(myview: UIView) -> UIView
    {
        let framex = myview.center.x
        let framey = myview.center.y
        
        var perso : UIImageView!
        let imageName = "vaisseau4.png"
        let image = UIImage(named: imageName)
        perso = UIImageView(image: image!)
       perso.frame = CGRect(x: framex - 25, y: framey + (framey * 70 / 100 ), width: 50, height: 80)
        return perso
    }
    func CountScore(LabalScore: UILabel,b: Int)
    {
        let first = "Score: " + String(b)
        LabalScore.text = first
    }
    
    func CountScoremor(LabalScore: UILabel,b: Int)
    {
        let first = "Score: " + String(b)
        LabalScore.text = first
    }
}
