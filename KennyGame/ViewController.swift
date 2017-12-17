//
//  ViewController.swift
//  KennyGame
//
//  Created by Bülent Siyah on 17.12.2017.
//  Copyright © 2017 Bülent Siyah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
   
    var score = 0
    var highscore = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "Score: \(score)"
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))

        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        kenny1.addGestureRecognizer(recognizer1)
         kenny2.addGestureRecognizer(recognizer2)
         kenny3.addGestureRecognizer(recognizer3)
         kenny4.addGestureRecognizer(recognizer4)
         kenny5.addGestureRecognizer(recognizer5)
         kenny6.addGestureRecognizer(recognizer6)
         kenny7.addGestureRecognizer(recognizer7)
         kenny8.addGestureRecognizer(recognizer8)
         kenny9.addGestureRecognizer(recognizer9)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
          hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKanny), userInfo: nil, repeats: true)
        
        
        counter = 30
        timeLabel.text = "\(counter)"
        
        kennyArray.append(kenny1)
        kennyArray.append(kenny2)
        kennyArray.append(kenny3)
        kennyArray.append(kenny4)
        kennyArray.append(kenny5)
        kennyArray.append(kenny6)
        kennyArray.append(kenny7)
        kennyArray.append(kenny8)
        kennyArray.append(kenny9)
        
        hideKanny()
        
        var temphighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if let item = temphighscore as? Int {
            highscore = item
        }
        highscoreLabel.text = "Highscore: \(highscore)"
        
        
    }

    
    @objc  func hideKanny(){
        for item in kennyArray{
            item.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false

    }
    
     @objc func countDown(){
        counter = counter - 1
        timeLabel.text = "\(counter)"
        
        if (counter <= 0){
            timer.invalidate()
              hideTimer.invalidate()
            
            if score > highscore {
                UserDefaults.standard.set(score, forKey: "highscore")
                highscore = score
                highscoreLabel.text = "Highscore: \(highscore)"
                UserDefaults.standard.synchronize()
            }
            
            let alert = UIAlertController(title: "Time", message: "Time's Up", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: .default, handler:{
                (UIAlertAction)
                in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKanny), userInfo: nil, repeats: true)
                
                
            })
            
            alert.addAction(replayButton)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }

    @objc func increaseScore(){
        
        score = score + 1
        
        scoreLabel.text = "Score: \(score)"
    }

}

