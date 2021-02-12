//
//  FocusViewController+Extension.swift
//  Windows
//
//  Created by xcv on 12/02/2021.
//

import Foundation
import UIKit

extension FocusViewController {
    func setupViews() {
        view.backgroundColor = Color.background
        navigationItem.title = "Focus"
        setupDarkNavBar()
        
        timerView = TimerView(frame: CGRect(x: 0, y: 0, width: view.frame.width / 1.5, height: view.frame.height / 1.5))
        timerView.translatesAutoresizingMaskIntoConstraints = false
        timerView.center = view.center
        timerView.layer.zPosition = -1
        
        sessionLabel.text = "Session"
        sessionDuration.text = String(sessionDurations.first!)
        
        breakLabel.text = "Break"
        breakDuration.text = String(breakDurations.first!)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitleColor(Color.lightLabel, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        startButton.setTitle("Start", for: .normal)
        startButton.addTarget(self, action: #selector(toggleAction), for: .touchUpInside)
        startButton.backgroundColor = Color.chocoBackground
        startButton.layer.cornerRadius = 60
        startButton.clipsToBounds = true
        
        detailsContainer.translatesAutoresizingMaskIntoConstraints = false
        detailsContainer.axis = .horizontal
        detailsContainer.distribution = .fillEqually
        detailsContainer.spacing = 30
        
        sessionView.translatesAutoresizingMaskIntoConstraints = false
        sessionView.distribution = .fillProportionally
        sessionView.axis = .vertical
        sessionView.alignment = .center
        sessionView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        sessionView.isLayoutMarginsRelativeArrangement = true
        
        breakView.translatesAutoresizingMaskIntoConstraints = false
        breakView.distribution = .fillProportionally
        breakView.axis = .vertical
        breakView.alignment = .center
        breakView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        breakView.isLayoutMarginsRelativeArrangement = true
        
        sessionLabel.textColor = Color.lightLabel
        sessionLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        sessionDuration.textColor = Color.grayLabel
        sessionDuration.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        
        breakLabel.textColor = Color.lightLabel
        breakLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        breakDuration.textColor = Color.grayLabel
        breakDuration.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        
        
        view.addSubview(timerView)
        view.addSubview(startButton)
        view.addSubview(detailsContainer)
        
        let containerSessionView = UIView()
        containerSessionView.backgroundColor = Color.chocoBackground
        containerSessionView.layer.cornerRadius = 6
        containerSessionView.translatesAutoresizingMaskIntoConstraints = false
        containerSessionView.addSubview(sessionView)
        detailsContainer.addArrangedSubview(containerSessionView)
        
        sessionView.addArrangedSubview(sessionLabel)
        sessionView.addArrangedSubview(sessionDuration)
        
        let containerBreakView = UIView()
        containerBreakView.backgroundColor = Color.chocoBackground
        containerBreakView.layer.cornerRadius = 6
        containerBreakView.translatesAutoresizingMaskIntoConstraints = false
        containerBreakView.addSubview(breakView)
        detailsContainer.addArrangedSubview(containerBreakView)
        breakView.addArrangedSubview(breakLabel)
        breakView.addArrangedSubview(breakDuration)
        
        
        let tapGestureSession = UITapGestureRecognizer(target: self, action: #selector(sessionClicked))
        tapGestureSession.delegate = self
        tapGestureSession.numberOfTapsRequired = 1
        containerSessionView.addGestureRecognizer(tapGestureSession)
        
        let tapGestureBreak = UITapGestureRecognizer(target: self, action: #selector(breakClicked))
        tapGestureBreak.delegate = self
        tapGestureBreak.numberOfTapsRequired = 1
        containerBreakView.addGestureRecognizer(tapGestureBreak)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(resetTimer))
        startButton.addGestureRecognizer(longGesture)
        
        startButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true
        
        startButton.heightAnchor.constraint(equalToConstant: 120).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        detailsContainer.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -60).isActive = true
        detailsContainer.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        
        breakView.topAnchor.constraint(equalTo: containerBreakView.topAnchor).isActive = true
        breakView.trailingAnchor.constraint(equalTo: containerBreakView.trailingAnchor).isActive = true
        breakView.bottomAnchor.constraint(equalTo: containerBreakView.bottomAnchor).isActive = true
        breakView.leadingAnchor.constraint(equalTo: containerBreakView.leadingAnchor).isActive = true
        
        sessionView.topAnchor.constraint(equalTo: containerSessionView.topAnchor).isActive = true
        sessionView.trailingAnchor.constraint(equalTo: containerSessionView.trailingAnchor).isActive = true
        sessionView.bottomAnchor.constraint(equalTo: containerSessionView.bottomAnchor).isActive = true
        sessionView.leadingAnchor.constraint(equalTo: containerSessionView.leadingAnchor).isActive = true
    }
    
    
    func setActionButtonTitle(text: String, animated: Bool) {
        if animated {
            UIView.transition(with: startButton, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.startButton.setTitle(text, for: .normal)
            }, completion: nil)
        } else {
            self.startButton.setTitle(text, for: .normal)
        }
    }
 
    func setupDarkNavBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.yellow]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .black
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // no white mode sorry
        setupDarkNavBar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
