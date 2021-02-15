//
//  ViewController.swift
//  Windows
//
//  Created by xcv on 06/02/2021.
//

import UIKit

class FocusViewController: UIViewController, UIGestureRecognizerDelegate {
    var focusView: FocusView!

    var timer = Timer()
    var typeTimer = TimerType.sessionTimer
    var seconds = 5 * 60

    var currentSessionIndex = 4
    let sessionDurations: [Int] = [5,10,15,20,25,30]
    
    var currentBreakIndex = 0
    let breakDurations: [Int] = [5,10,15]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupGestures()
        setupTimer()
    }
    
    func setupViews() {
        setupDarkNavBar()
        
        focusView = FocusView(frame: view.frame)
        focusView.updateSessionDuration(duration: sessionDurations[currentSessionIndex])
        focusView.updateBreakDuration(duration: breakDurations[currentBreakIndex])
        focusView.startButton.addTarget(self, action: #selector(toggleAction), for: .touchUpInside)
        
        view.addSubview(focusView)
    }
    
    func setupGestures() {
        let tapGestureSession = UITapGestureRecognizer(target: self, action: #selector(sessionClicked))
        tapGestureSession.delegate = self
        tapGestureSession.numberOfTapsRequired = 1
        focusView.containerSessionView.addGestureRecognizer(tapGestureSession)
        
        let tapGestureBreak = UITapGestureRecognizer(target: self, action: #selector(breakClicked))
        tapGestureBreak.delegate = self
        tapGestureBreak.numberOfTapsRequired = 1
        focusView.containerBreakView.addGestureRecognizer(tapGestureBreak)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(resetTimer))
        focusView.startButton.addGestureRecognizer(longGesture)
    }
    
    func setupTimer() {
        // MARK: 0 - state for stopped timer, 1 - for started
        focusView.startButtonState = .stopped
        
        // MARK: Calculate total time of session with break
        seconds = (sessionDurations[currentSessionIndex] * 60) + (breakDurations[currentBreakIndex] * 60)
    }
    
    @objc func toggleAction() {
        if focusView.startButtonState == .stopped {
            focusView.startButtonState = .started
            startTimer()
        } else {
            focusView.startButtonState = .stopped
            stopTimer()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,  selector: (#selector(start)), userInfo: nil, repeats: true)
        
        Vibration.success.vibrate()
    }
    
    func stopTimer() {
        timer.invalidate()
        updateStatusLabel(state: .paused)
        
        Vibration.heavy.vibrate()
    }
    
    @objc func resetTimer() {
        focusView.startButtonState = .stopped
        typeTimer = .sessionTimer

        timer.invalidate()
        
        focusView.setActionButtonTitle(text: StartLabel.start.rawValue, animated: true)
        focusView.setStatusText(text: StatusLabel.notStartedText.rawValue, animated: true)
        
        // MARK: Calculate total time of session with break
        seconds = (sessionDurations[currentSessionIndex] * 60) + (breakDurations[currentBreakIndex] * 60)
        focusView.timerView.setProgressValue(to: 0)
        
        Vibration.rigid.vibrate()
    }
    
    
    @objc func start() {
        let totalTime = (sessionDurations[currentSessionIndex] * 60) + (breakDurations[currentBreakIndex] * 60)
        
        if seconds > 0 {
            seconds -= 1
            
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .positional
            
            let formattedString = formatter.string(from: TimeInterval(seconds))!
            let percentageTime = Float(Float(totalTime-seconds)/Float(totalTime))
            let valueForTimer = percentageTime * 100
            
            if seconds <= (sessionDurations[currentSessionIndex] * 60) + (breakDurations[currentBreakIndex] * 60) {
                focusView.timerView.setProgressValue(to: Float(valueForTimer))
                focusView.setActionButtonTitle(text: "\(formattedString)", animated: false)
            }
            
            updateTimerType()
            updateStatusLabel(state: .running)
        } else {
            resetTimer()
        }

    }
    
    func updateTimerType() {
        if seconds <= (breakDurations[currentBreakIndex] * 60) {
            if typeTimer != .breakTimer {
                typeTimer = .breakTimer
            }
        }
    }
    

    func updateStatusLabel(state: TimerState) {
        if state == .running {
            if typeTimer == .sessionTimer && focusView.statusLabel.text != StatusLabel.sessionText.rawValue {
                focusView.setStatusText(text: StatusLabel.sessionText.rawValue, animated: true)
            } else if typeTimer == .breakTimer && focusView.statusLabel.text != StatusLabel.breakText.rawValue {
                focusView.setStatusText(text: StatusLabel.breakText.rawValue, animated: true)
            }
            
        } else if state == .paused{
           
            switch typeTimer {
            case .breakTimer:
                focusView.setStatusText(text: StatusLabel.breakPausedText.rawValue, animated: true)
            case .sessionTimer:
                focusView.setStatusText(text: StatusLabel.sessionPausedText.rawValue, animated: true)
            }
        }
        
       
    }
    
    @objc func sessionClicked() {
        if currentSessionIndex < sessionDurations.count - 1 {
            currentSessionIndex += 1
            focusView.updateSessionDuration(duration: sessionDurations[currentSessionIndex])
        } else {
            currentSessionIndex = 0
            focusView.updateSessionDuration(duration: sessionDurations[currentSessionIndex])
        }
        resetTimer()
        
        Vibration.soft.vibrate()
    }
    
    @objc func breakClicked() {
        if currentBreakIndex < breakDurations.count - 1 {
            currentBreakIndex += 1
            focusView.updateBreakDuration(duration: breakDurations[currentBreakIndex])
        } else {
            currentBreakIndex = 0
            focusView.updateBreakDuration(duration: breakDurations[currentBreakIndex])
        }
        resetTimer()
        
        Vibration.soft.vibrate()

    }
    
}

