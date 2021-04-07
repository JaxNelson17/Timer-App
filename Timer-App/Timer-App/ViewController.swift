//
//  ViewController.swift
//  Timer-App
//
//  Created by Jaxson Nelson on 4/6/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var randomGameTimerLabel: UILabel!
    @IBOutlet weak var minTextField: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBAction func UITapGestureRecognize(_ sender: UITapGestureRecognizer) {
    }
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        minTextField.delegate = self
        maxTextField.delegate = self
        timerLabel.text = String(getRandomTime())
        configureTapGesture()
    }
    
    var MyTimer = Timer()
    var TimerDisplayed = 0
    var seconds = 0
    var timerRunning = false
    var resumeTapped = false
    var audio: AVAudioPlayer?
    
    
    @IBAction func startTimer(_ sender: UIButton) {
        if timerRunning == false {
            self.startButton.isEnabled = false
            runTimer()
            seconds = getRandomTime()
            Actions()
            self.startButton.isEnabled = true
        }
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        MyTimer.invalidate()
        TimerDisplayed = 0
        timerLabel.text = "0"
        timerRunning = false
        
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        if self.resumeTapped == false {
            MyTimer.invalidate()
            self.resumeTapped = true
        } else {
            runTimer()
            self.resumeTapped = false
        }

    }
    
    @IBAction func resetTimer(_ sender: UIButton) {
        MyTimer.invalidate()
        TimerDisplayed = 0
        timerLabel.text = "0"
        minTextField.text = ""
        maxTextField.text = ""
        timerRunning = false
    }
    
    @objc func Actions() {
        seconds -= 1
        timerLabel.text = String(seconds)
        if seconds == 0 {
            MyTimer.invalidate()
            timerRunning = false
            let path = Bundle.main.path(forResource: "LegoYodaDeath", ofType: "mp3")!
            let url = URL(fileURLWithPath: path)
            do {
                audio = try AVAudioPlayer(contentsOf: url)
                audio?.play()
            } catch {
                print("Could not load audio")
            }
        }
        
    }
    

    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func didTapMinTxt(_ sender:UIButton) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func getRandomTime() -> Int{
        if let min = Int(minTextField.text ?? ""), let max = Int(maxTextField.text ?? "") {
            let randomNum = Int.random(in: min ... max)
            return randomNum
        } else {
            return 0
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")) == nil
    }
    
    func runTimer() {
        MyTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Actions), userInfo: nil, repeats: true)
        timerRunning = true
    }
    
    func pausedTimer() {
        if self.resumeTapped == false {
            MyTimer.invalidate()
            self.resumeTapped = true
        } else {
            runTimer()
            self.resumeTapped = false
        }
    }
}


