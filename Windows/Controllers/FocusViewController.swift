//
//  ViewController.swift
//  Windows
//
//  Created by xcv on 06/02/2021.
//

import UIKit

class FocusViewController: UIViewController, UIGestureRecognizerDelegate {
    var timerView: TimerView!
    var startButton = UIButton()
    var detailsContainer = UIStackView()
    var sessionView = UIStackView()
    var sessionLabel = UILabel()
    var breakLabel = UILabel()
    var breakView = UIStackView()
    var sessionDuration = UILabel()
    var breakDuration = UILabel()
    
    var timer = Timer()
    
    var currentSessionIndex = 0
    let sessionDurations: [Int] = [5,10,15,20,25,30]
    
    var currentBreakIndex = 0
    let breakDurations: [Int] = [5,10,15]
    
    var duration = 5 * 60
    var seconds = 5 * 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.tag = 0
        setupViews()
    }
    
    @objc func toggleAction() {
        if startButton.tag == 0 {
            startButton.tag = 1
            startTimer()
            
        } else {
            startButton.tag = 0
            stopTimer()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,  selector: (#selector(start)), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
        seconds = sessionDurations[0] * 60
        duration = breakDurations[0] * 60
        
        setActionButtonTitle(text: "Start", animated: true)
        timerView.changeProgressValue(to: 0)
    }
    
    @objc func resetTimer() {
        startButton.tag = 0
        stopTimer()
        
        setActionButtonTitle(text: "Start", animated: true)
        seconds = sessionDurations[currentSessionIndex] * 60
        timerView.changeProgressValue(to: 0)
    }
    
    
      @objc func start() {
          seconds = sessionDurations[currentSessionIndex] * 60

          seconds -= 1
          
          let formatter = DateComponentsFormatter()
          formatter.allowedUnits = [.hour, .minute, .second]
          formatter.unitsStyle = .positional
          
          let totalTime = sessionDurations[currentSessionIndex] * 60
          let formattedString = formatter.string(from: TimeInterval(seconds))!
          let percentageTime = Float(Float(totalTime-seconds)/Float(totalTime))
          let valueForTimer = percentageTime * 100
          
          if seconds <= sessionDurations[currentSessionIndex] * 60 {
              timerView.changeProgressValue(to: Float(valueForTimer))
              setActionButtonTitle(text: formattedString, animated: false)
          }
      }

    @objc func sessionClicked() {
        stopTimer()
        if currentSessionIndex < sessionDurations.count - 1 {
            currentSessionIndex += 1
            seconds = sessionDurations[currentSessionIndex] * 60
            sessionDuration.text = String(sessionDurations[currentSessionIndex])
        } else {
            currentSessionIndex = 0
            sessionDuration.text = String(sessionDurations[currentSessionIndex])
        }
    }
    
    @objc func breakClicked() {
        stopTimer()
        if currentBreakIndex < breakDurations.count - 1 {
            currentBreakIndex += 1
            seconds = breakDurations[currentBreakIndex] * 60
            breakDuration.text = String(breakDurations[currentBreakIndex])
        } else {
            currentBreakIndex = 0
            breakDuration.text = String(breakDurations[currentBreakIndex])
        }
    }

    @objc func startButtonClicked() {
        timerView.changeProgressValue(to: Float(Int.random(in: 1...100)))
    }

}

