//
//  ViewController.swift
//  BullsEye
//
//  Created by Alondra Rodríguez on 01/03/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var slider: UISlider! //I put this here because I need it as instance variable
    
    @IBOutlet var targetLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var roundLabel: UILabel!
    
    
    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)

        let thumbImageHighlighted = UIImage(
          named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)

        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(
          withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
          withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)

    }
    
    func updateLabels () {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
        
    @IBAction func showalert() {
        
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
            score += points
        
    
        let message = "Your scored is \(points) points"
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        
        /*let action = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: { _ in
                self.startNewRound()
            }) This is bottom alert, another way to type it*/
        
        let action = UIAlertAction(
          title: "OK",
          style: .default) {_ in
          self.startNewRound()
        } //another way

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value) //This is a variable
        print("The value of the slider is now: \(slider.value)")
    }
    
    @IBAction func startNewGame () {
        round = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound () {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
}
