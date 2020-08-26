//
//  ViewController.swift
//  BullsEye
//
//  Created by Andrew Maher on 8/25/20.
//  Copyright © 2020 Andrew Maher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var sliderValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        sliderValue = lroundf(slider.value)
        startOver()
        adjustSliderUI()
    }
    
    func adjustSliderUI(){
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal") //UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted") //UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")//UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight") //UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    func startNewRound(){
        round += 1
        generateRandomNum(upTo: 100)
        reInitializeSlider()
        updateLabels()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func generateRandomNum(upTo: Int){
        targetValue = 1 + Int(arc4random_uniform(100))
    }
    
    func reInitializeSlider(){
        sliderValue = 50
        slider.value = Float(sliderValue)
    }
    
    func calculateScore() -> Int{
        let differenceScore = abs(targetValue - sliderValue)
        let points: Int = 100 - differenceScore
        score += points
        return points
    }

    func createTitleBaseOnPoints(difference: Int)->String{
        if difference == 0{
            score += 100
            return  "Perfect!"
        }else if difference < 5{
            return "You almost had it!"
        }else if difference < 10{
            return "Pretty good!"
        }else{
            return "Not even close..."
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func sliderMoved(_ slider: UISlider){
        sliderValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert(){
        let points = calculateScore()
        let title: String = createTitleBaseOnPoints(difference: abs(points - 100))
        let message = "You scored \(points)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler:{
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOver(){
        score = 0
        round = 0
        startNewRound()
    }
}

