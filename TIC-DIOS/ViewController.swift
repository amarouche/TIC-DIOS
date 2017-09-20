//
//  ViewController.swift
//  TIC-DIOS
//
//  Created by Ouahab Koussaila AMAROUCHE on 21/07/2017.
//  Copyright © 2017 Ouahab Koussaila AMAROUCHE. All rights reserved.
//

import UIKit
import Darwin
class ViewController: UIViewController {
    
    var timerstar: Timer!
    var timerpopstar: Timer!
    var stars: [UIImageView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        timerpopstar = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(t:Timer) in  self.generStar()})
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func generStar()
    {
        let imageName = "star.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: Int(20 + arc4random_uniform(UInt32(self.view.frame.width - 50))), y: 0, width: 10, height: 10)
        view.addSubview(imageView)
        stars.append(imageView)
        animateStar(imageView)
    }
    
    private func animateStar (_ img: UIImageView)
    {
        timerstar = Timer.scheduledTimer(withTimeInterval: 0.005, repeats: true, block: {(m:Timer) in
            img.center.y = img.center.y + 1
            
            self.stars.forEach( {(ennemy: UIImageView) in
                if (ennemy.center.y >= self.view.frame.height){
                    self.stars.remove(at: self.stars.index(of: ennemy)!)
                    ennemy.removeFromSuperview()
                    return
                }
            })
            
        })
    }


//    @IBAction func exit(_ sender: Any) {
//     exit(0)
//    }
}

