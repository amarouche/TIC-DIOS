//
//  ViewGameControllor.swift
//  TIC-DIOS
//
//  Created by Ouahab Koussaila AMAROUCHE on 21/07/2017.
//  Copyright © 2017 Ouahab Koussaila AMAROUCHE. All rights reserved.
//

import UIKit
class ViewGameController: UIViewController {

    var perso : UIImageView!
    var coeured : UIImageView!
    var  animation : UIViewPropertyAnimator!
    var collision: UICollisionBehavior!
    var ennemi: [UIImageView] = []
    var timer: Timer!
    var level = String()
    var timerenemy : Timer!
    var timerpopenemy :Timer!
    var animateBullet : Timer!
    var animateShoot : Timer!
    var timershot : Timer!
    var timerscore : Timer!
    var timershotenemy : Timer!
    var i = 0
    var c = 3
    var labalscore : UILabel!
    let instanceOfUser = User()
    let instanceOfEnemy = Enemy()
    var pseu : String!
   
    @IBOutlet var scorelabel: UILabel!
    @IBOutlet var ViewDead: UIView!
    @IBOutlet var score: UILabel!
    @IBOutlet var life: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let views = self.view
        perso = instanceOfUser.create_perso(myview: views!) as! UIImageView
        view.addSubview(perso)
        AllTimers()
        scorelabel.text = pseu
        print(pseu)
    }
    
    
    func AllTimers()
    {
        timerpopenemy = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(t:Timer) in  self.generEnemy()})
        timershot = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {(t:Timer) in  self.generateBullet()})
        timerscore = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {(m:Timer) in self.instanceOfUser.CountScore(LabalScore: self.score, b: self.i)
            self.i += 1}
        )
        ViewDead.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func moveTUIBtn(_ sender: UIButton) {
         timer.invalidate()
        //self.perso.image = UIImage(named: "ninja_")
    }
    
    @IBAction func moveTDBtn(_ sender: UIButton) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {(t:Timer) in
            if sender.tag == 1{
                if self.perso.center.x >= sender.frame.origin.x + sender.frame.size.width - (self.perso.frame.size.width / 4){
                    self.perso.center.x = sender.frame.origin.x + sender.frame.size.width - (self.perso.frame.size.width / 4)
                }else{
                self.perso.center.x = self.perso.center.x + 2
                //self.perso.image = #imageLiteral(resourceName: "ninja2")
                }
            }
           else{
                if self.perso.center.x <= sender.frame.origin.x + (self.perso.frame.size.width / 4) {
                    self.perso.center.x = sender.frame.origin.x + (self.perso.frame.size.width / 4)
                }
                else{
                    self.perso.center.x = self.perso.center.x - 2
                }
            }
        })
    }

    func generEnemy()
    {
        let imageName = "vaisseau2.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: Int(20 + arc4random_uniform(UInt32(self.view.frame.width - 50))), y: 0, width: 40, height: 50)
        view.addSubview(imageView)
        ennemi.append(imageView)
        animateEnnemi(imageView)
    }
    
    func generateBullet()
   {
    let xx = Int(self.perso.layer.presentation()!.position.x)
    let yy = Int(self.perso.layer.presentation()!.position.y)
    var bulle : UIImageView!
     bulle = instanceOfEnemy.generBull(persox: xx,persoy: yy) as! UIImageView

       animateBullet = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (animateBullet) in
            bulle.center.y = bulle.center.y - 2;
        //if (!self.view.superview!.bounds.contains(bulle.frame)){
            self.instanceOfEnemy.bullecvsenemy(boole: true, bulle: bulle)
        //}
            self.ennemi.forEach({ (ennemy: UIImageView) in
                if (ennemy.frame.intersects(bulle.frame)) {
                    print("touché")
                    ennemy.image = #imageLiteral(resourceName: "explosion2")
                    self.i += 100
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        ennemy.removeFromSuperview();
                    })
                    self.ennemi.remove(at: self.ennemi.index(of: ennemy)!)
                    bulle.removeFromSuperview();
                    animateBullet.invalidate()
                    return
                }
            })
        })
    view.addSubview(bulle)
    }
    
    func generenemyshoot()
    {
        self.ennemi.forEach({ (ennemy: UIImageView) in
            let xx = Int(ennemy.center.x)
            let yy = Int(ennemy.center.y + 60)
            var bulle : UIImageView!
            bulle = instanceOfEnemy.EnemyShoot(persox: xx,persoy: yy) as! UIImageView
            animateShoot = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (animateShoot) in
            bulle.center.y = bulle.center.y + 2;
            //if (!self.view.superview!.bounds.contains(bulle.frame)){
                self.instanceOfEnemy.Shootvsperso(boole: true, bulle: bulle)
           // }
                if (bulle.frame.intersects(self.perso.frame)) {
                    self.c -= 1
                    bulle.removeFromSuperview();
                    animateShoot.invalidate()
                    return
                    }
                
                self.instanceOfEnemy.lifecoeur(z: self.c, imge: self.life, labview: self.ViewDead, scorelabel: self.scorelabel, i: self.i, imgperso: self.perso, name: self.pseu, temps: self.timerpopenemy, tempshoot: self.timershot, scr: self.score, tmp: self.timerscore)
            })
        view.addSubview(bulle)
        })
    }

    private func animateEnnemi (_ img: UIImageView)
    {
        timerenemy = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {(m:Timer) in
            self.instanceOfEnemy.selectlevel(img: img,level: self.level)
           if(self.level == "Difficile"){
            self.level = ""
                img.center.y = img.center.y + 1
                self.timershotenemy = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: {(t:Timer) in  self.generenemyshoot()})
            }
            self.ennemi.forEach( {(ennemy: UIImageView) in
               if (Int(ennemy.center.y) >= (Int(self.view.frame.height))){
                    self.ennemi.remove(at: self.ennemi.index(of: ennemy)!)
                    ennemy.removeFromSuperview()
                    return
                }
            })
            self.ennemi.forEach( {(enemy: UIImageView) in
                if (enemy.frame.intersects(self.perso.frame))
                    {
                        self.ennemi.remove(at: self.ennemi.index(of: enemy)!)
                        enemy.removeFromSuperview()
                        NSLog("They intersect")
                        self.c -= 1
                    }
                self.instanceOfEnemy.lifecoeur(z: self.c, imge: self.life,labview: self.ViewDead, scorelabel: self.scorelabel,i: self.i, imgperso: self.perso, name: self.pseu, temps: self.timerpopenemy, tempshoot: self.timershot, scr: self.score, tmp: self.timerscore)
            })
        })
    }
    
    
    @IBAction func menu(_ sender: Any) {
        animateBullet.invalidate()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as! ViewController
        self.present(nextViewController, animated:true, completion:nil)
    }

}


