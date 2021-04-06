//
//  ViewController.swift
//  Timer-App
//
//  Created by Jaxson Nelson on 4/6/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var randomGameTimerLabel: UILabel!
    @IBOutlet weak var minTextField: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBAction func UITapGestureRecognize(_ sender: UITapGestureRecognizer) {
    }
    
    

    var MyTimer = Timer()
    var TimerDisplayed = 0
    
    
    @IBAction func startTimer(_ sender: UIButton) {
        MyTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Actions), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        MyTimer.invalidate()
        TimerDisplayed = 0
        timerLabel.text = "0"
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        MyTimer.invalidate()
    }
    
    @IBAction func resetTimer(_ sender: UIButton) {
        MyTimer.invalidate()
        TimerDisplayed = 0
        timerLabel.text = "0"
        minTextField.text = ""
        maxTextField.text = ""
    }
    
    @objc func Actions() {
        TimerDisplayed -= 1
        timerLabel.text = String(TimerDisplayed)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        minTextField.delegate = self
        maxTextField.delegate = self
        
        configureTapGesture()
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
}
   
