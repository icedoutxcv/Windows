//
//  ViewController.swift
//  Windows
//
//  Created by xcv on 06/02/2021.
//

import UIKit

class FocusViewController: UIViewController, UIGestureRecognizerDelegate {
    var focusView: FocusView!

    // MARK: Create timer
    var timer = Timer()
    var typeTimer = TimerType.sessionTimer
    
    var seconds: Int = 0

    // MARK: Default duration for session = 20min
    var currentSessionIndex = 4
    let sessionDurations: [Int] = [5,10,15,20,25,30]
    
    // MARK: Default duration for break = 5min
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
        
        // MARK: Create FocusView and set default values for session/break durations
        focusView = FocusView(frame: view.frame)
        focusView.updateSessionDuration(duration: sessionDurations[currentSessionIndex])
        focusView.updateBreakDuration(duration: breakDurations[currentBreakIndex])
        focusView.startButton.addTarget(self, action: #selector(toggleAction), for: .touchUpInside)
        
        view.addSubview(focusView)
    }
    
    // MARK: Capture clicks for sessionView/breakView and long-press for startButton
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
    
    // MARK: Toggle functionality for started/stopped state
    @objc func toggleAction() {
        switch focusView.startButtonState {
        case .stopped:
            focusView.startButtonState = .started
            startTimer()
        case .started:
            focusView.startButtonState = .stopped
            stopTimer()
        }
    }
    
    // MARK: Create timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,  selector: (#selector(start)), userInfo: nil, repeats: true)
        
        Vibration.success.vibrate()
    }
    
    // MARK: Stop timer and update labels
    func stopTimer() {
        timer.invalidate()
        updateStatusLabel(state: .paused)
        
        Vibration.heavy.vibrate()
    }
    
    // MARK: Reset timer and update labels
    @objc func resetTimer() {
        
        // MARK: Change state and type
        focusView.startButtonState = .stopped
        typeTimer = .sessionTimer
        
        // MARK: Stop timer
        timer.invalidate()
        
        // MARK: Update labels
        focusView.setActionButtonTitle(text: NSLocalizedString("Start", comment: ""), animated: true)
        focusView.setStatusText(text: NSLocalizedString("Not started", comment: ""), animated: true)
        
        // MARK: Calculate total time of session with break
        seconds = (sessionDurations[currentSessionIndex] * 60) + (breakDurations[currentBreakIndex] * 60)
        
        // MARK: Set progress for timerView circle
        focusView.timerView.setProgressValue(to: 0)
        
        Vibration.rigid.vibrate()
    }
    
    // MARK: Start counting
    @objc func start() {
        let totalTime = (sessionDurations[currentSessionIndex] * 60) + (breakDurations[currentBreakIndex] * 60)
        
        // MARK: Check if elapsed second are not negative
        if seconds > 0 {
            seconds -= 30
            
            // MARK: Add formatter
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .positional
            
            let formattedString = formatter.string(from: TimeInterval(seconds))!
            let percentageTime = Float(Float(totalTime-seconds)/Float(totalTime))
            let valueForTimer = percentageTime * 100
            
            // MARK: Update circle value for TimerView
            focusView.timerView.setProgressValue(to: Float(valueForTimer))
            
            // MARK: Update label with formatted string
            focusView.setActionButtonTitle(text: "\(formattedString)", animated: false)
            
            // MARK: Update timer type
            updateTimerType()
            
            // MARK: Update label for .running state
            updateStatusLabel(state: .running)
        } else {
            resetTimer()
        }

    }
    
    // MARK: Update timer type if its time for break
    func updateTimerType() {
        if seconds <= (breakDurations[currentBreakIndex] * 60) {
            if typeTimer != .breakTimer {
                typeTimer = .breakTimer
            }
        }
    }

    // MARK: Update current status label for different states of timer
    func updateStatusLabel(state: TimerState) {
        switch state {
        // MARK: Update status label text for running state
        case .running:
            // MARK: Check if its session or break time/if correct label text is set
            if typeTimer == .sessionTimer && focusView.statusLabel.text != NSLocalizedString("Session..", comment: "") {
                focusView.setStatusText(text: NSLocalizedString("Session..", comment: ""), animated: true)
            } else if typeTimer == .breakTimer && focusView.statusLabel.text != NSLocalizedString("Break..", comment: "") {
                focusView.setStatusText(text: NSLocalizedString("Break..", comment: ""), animated: true)
            }
        // MARK: Update status label text for paused state
        case .paused:
            switch typeTimer {
            case .sessionTimer:
                focusView.setStatusText(text: NSLocalizedString("Session paused", comment: ""), animated: true)
            case .breakTimer:
                focusView.setStatusText(text: NSLocalizedString("Break paused", comment: ""), animated: true)
            }
        }
    }
    
    // MARK: Toggle label text if session duration view is tapped then reset timer
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
    
    // MARK: Toggle label text if break duration view is tapped then reset timerr
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

