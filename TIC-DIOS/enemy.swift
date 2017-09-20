//
//  enemi.swift
//  TIC-DIOS
//
//  Created by Ouahab Koussaila AMAROUCHE on 26/07/2017.
//  Copyright © 2017 Ouahab Koussaila AMAROUCHE. All rights reserved.
//

import Foundation

import UIKit

class Enemy: NSObject {
    var animateBullet : Timer!
    var animateShoot : Timer!
    var timershootenemy : Timer!
    
    func generBull(persox: Int, persoy: Int)-> UIView{
        let imageName = "shoot3.png"
        let image = UIImage(named: imageName)
        let bulle = UIImageView(image: image!)
        bulle.frame = CGRect(x: persox - 15 , y: persoy - 65, width: 40, height: 25)
        return bulle
    }
    
    func bullecvsenemy(boole: Bool, bulle: UIImageView ){
        if (!boole)
            {
                bulle.removeFromSuperview();
                animateBullet.invalidate()
                return
            }
    }
    
    func lifecoeur(z: Int, imge: UIImageView, labview: UIView, scorelabel: UILabel, i: Int, imgperso: UIImageView,name: String, temps: Timer, tempshoot: Timer, scr : UILabel, tmp: Timer){
        var variable = String()
        var psd = String()
        if (z == 2){
            imge.image = #imageLiteral(resourceName: "life2")
        }
        else if(z == 1){
            imge.image = #imageLiteral(resourceName: "life1")
        }
        else if(z == 0){
            imge.image = #imageLiteral(resourceName: "life")
            imgperso.image = #imageLiteral(resourceName: "explosion3")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                imgperso.removeFromSuperview();
            })
            tmp.invalidate()
            temps.invalidate()
            tempshoot.invalidate()
            variable = String(i)
            psd = name + "  "
            scorelabel.text = psd + variable
            scorelabel.textAlignment = .center;
            labview.addSubview(scorelabel)
            labview.isHidden = false
            scr.removeFromSuperview();
        }
    }
    
    func deletEnemy(allen: [UIImageView], vu: Int){
        var allimage: [UIImageView] = []
        allimage = allen
        allimage.forEach( {(ennemy: UIImageView) in
            if (Int(ennemy.center.y) >= (Int(vu))){
                allimage.remove(at: allen.index(of: ennemy)!)
                ennemy.removeFromSuperview()
                return
            }
        })
    }
    
    func EnemyShoot(persox: Int, persoy: Int)-> UIView{
        let imageName = "shoot1.png"
        let image = UIImage(named: imageName)
        let shoot = UIImageView(image: image!)
        shoot.frame = CGRect(x: persox - 15 , y: persoy - 65, width: 35, height: 25)
        return shoot
    }
    
    func Shootvsperso(boole: Bool, bulle: UIImageView ){
        if (!boole)
            {
                bulle.removeFromSuperview();
                animateShoot.invalidate()
                return
            }
    }
    func selectlevel(img: UIImageView,level : String){
        
        if(level == "Moyen")
        {
            img.center.y = img.center.y + 5
        }
        else{
            img.center.y = img.center.y + 1
        }
    }
}
