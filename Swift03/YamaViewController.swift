//
//  YamaViewController.swift
//  Swift03
//
//  Created by 王铁刚 on R 2/04/25.
//  Copyright © Reiwa 2 王铁刚. All rights reserved.
//

import UIKit

class YamaViewController: UIViewController {

    var num = 0
    @IBOutlet weak var myLabel: UILabel!
    
    @objc func step() {
        num += 1
        myLabel.text = String(num)
        UIView.transition(with: myLabel, duration: 0.5, options: [.transitionFlipFromRight], animations: nil, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.step), userInfo: nil, repeats: true)
        myLabel.text = String(num)
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        let flower = UIImageView(image: UIImage(named: "flower"))
        flower.alpha = 0
//        let scaleTransform = CGAffineTransform(scaleX: 0.2, y: 0.2)
//        let rotationTransform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
//        let newTransform = scaleTransform.concatenating(rotationTransform)
//        flower.transform = newTransform
        flower.center = sender.location(in: self.view)
        view.addSubview(flower)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
                        flower.alpha = 1.0
        }, completion: {(finished: Bool) in
            self.fadeoutAndRemove(flower)
        })
    }
    
    func fadeoutAndRemove(_ view: UIView) {
        UIView.animateKeyframes(
            withDuration: 2.0,
            delay: 3.0,
            options: [],
            animations: {
                view.alpha = 0.0
        }) { (finished: Bool) in
            view.removeFromSuperview()
        }
    }
    
}
