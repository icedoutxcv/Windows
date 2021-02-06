//
//  ViewController.swift
//  Windows
//
//  Created by xcv on 06/02/2021.
//

import UIKit

class FocusViewController: UIViewController {
    var timerView: TimerView!
    var startButton = UIButton()
    
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    
    @objc func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        startButton.setTitle("\(seconds)", for: .normal) //This will update the label.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = UIColor(red: 254, green: 228, blue: 0, alpha: 25)
        navigationItem.title = "Focus"
        setupDarkNavBar()

        timerView = TimerView(frame: CGRect(x: 0, y: 0, width: view.frame.width / 1.5, height: view.frame.height / 1.5))
        timerView.translatesAutoresizingMaskIntoConstraints = false
        timerView.center = view.center
        timerView.layer.zPosition = -1

        startButton.setTitleColor(.black, for: .normal)
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(runTimer), for: .touchUpInside)
        
        view.addSubview(timerView)
        view.addSubview(startButton)
    }
        
    func setupConstraints() {
        startButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true

        startButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    @objc func startButtonClicked() {
        timerView.changeProgressValue(to: Float(Int.random(in: 1...100)))
    }
    
    func setupDarkNavBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.yellow]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .black
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
        
        // no white-mode
        setupDarkNavBar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

