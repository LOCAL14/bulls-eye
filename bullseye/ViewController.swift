//
//  ViewController.swift
//  bullseye
//
//  Created by 夏震 on 2017/7/8.
//  Copyright © 2017年 夏震. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider:UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewGame()
        updateLabels()
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbHighLighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbHighLighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        /*Complicated method
        var difference: Int
        if currentValue > targetValue {
            difference = currentValue - targetValue
        }else if currentValue < targetValue{
            difference = targetValue - currentValue
        }else  {
            difference = 0
        }*/
        /*Another complicated method
        var difference = targetValue - currentValue
        if difference < 0{
           difference = -difference
        }*/
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        let title: String
        if points == 100 {
            title = "完美～"
            points += 100
        }else if points > 95 {
            title = "就差一点！"
            if points == 99 {
                points += 50
            }
        }else if points > 90 {
            title = "诶呦～不错呦"
        }else {
            title = "差的有点远..."
        }
        score += points
        let message = "你的分数是 \(points)"
        let alert = UIAlertController(title:title, message:message, preferredStyle: .alert)
        let action = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            self.startNewRound()
            self.updateLabels()
        })
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider:UISlider){
        currentValue =  lroundf(slider.value)
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
    func startNewRound() {
        round += 1
        targetValue =  1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    func startNewGame() {
        round = 0
        score = 0
        startNewRound()
    }
    
    func updateLabels() {
             targetLabel.text = String(targetValue)
             scoreLabel.text = String(score)
             roundLabel.text = String(round)
    }
    
    
}

