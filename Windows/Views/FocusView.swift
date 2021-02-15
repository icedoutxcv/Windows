//
//  FocusView.swift
//  Windows
//
//  Created by xcv on 15/02/2021.
//

import Foundation
import UIKit

class FocusView: UIView {
    var startButtonState = ButtonState.stopped

    lazy var timerView: TimerView = {
        let  timerView = TimerView(frame: CGRect(x: 0, y: 0, width: frame.width / 1.5, height: frame.height / 1.5))
        timerView.translatesAutoresizingMaskIntoConstraints = false
        timerView.center = center
        timerView.layer.zPosition = -1
        return timerView
    }()
    
    var statusLabel: CustomLabel = {
        let label = CustomLabel(withInsets: 10, 10, 10, 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "lightLabel")
        label.text = NSLocalizedString("Not started", comment: "")
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.layer.backgroundColor = UIColor(named: "chocoBg")?.cgColor
        label.layer.cornerRadius = 6
        return label
    }()
    
    var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(named: "lightLabel"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        button.setTitle(NSLocalizedString("Start", comment: ""), for: .normal)
        button.backgroundColor = UIColor(named: "chocoBg")
        button.layer.cornerRadius = 60
        button.clipsToBounds = true
        return button
    }()
    
    var detailsContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        return stackView
    }()
    
    var containerSessionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "chocoBg")
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var sessionView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    var sessionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Session", comment: "")
        label.textColor = UIColor(named: "lightLabel")
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    var sessionDuration: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayLabel")
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        return label
    }()
    
    var containerBreakView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "chocoBg")
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var breakView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    var breakLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Break", comment: "")
        label.textColor = UIColor(named: "lightLabel")
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    var breakDuration: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayLabel")
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor(named: "background")
    }
    
    func setupHierarchy() {
        addSubview(timerView)
        addSubview(startButton)
        addSubview(statusLabel)
        addSubview(detailsContainer)
        
        containerSessionView.addSubview(sessionView)
        detailsContainer.addArrangedSubview(containerSessionView)
        
        containerBreakView.addSubview(breakView)
        detailsContainer.addArrangedSubview(containerBreakView)
        
        sessionView.addArrangedSubview(sessionLabel)
        sessionView.addArrangedSubview(sessionDuration)
        
        breakView.addArrangedSubview(breakLabel)
        breakView.addArrangedSubview(breakDuration)
    }
    
    func setupLayout() {
        startButton.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 120).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        statusLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 60).isActive = true
        statusLabel.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor).isActive = true
        
        detailsContainer.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -60).isActive = true
        detailsContainer.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor).isActive = true
        
        breakView.topAnchor.constraint(equalTo: containerBreakView.topAnchor).isActive = true
        breakView.trailingAnchor.constraint(equalTo: containerBreakView.trailingAnchor).isActive = true
        breakView.bottomAnchor.constraint(equalTo: containerBreakView.bottomAnchor).isActive = true
        breakView.leadingAnchor.constraint(equalTo: containerBreakView.leadingAnchor).isActive = true
        
        sessionView.topAnchor.constraint(equalTo: containerSessionView.topAnchor).isActive = true
        sessionView.trailingAnchor.constraint(equalTo: containerSessionView.trailingAnchor).isActive = true
        sessionView.bottomAnchor.constraint(equalTo: containerSessionView.bottomAnchor).isActive = true
        sessionView.leadingAnchor.constraint(equalTo: containerSessionView.leadingAnchor).isActive = true
    }
    
    // MARK: Set startButton label text
    func setActionButtonTitle(text: String, animated: Bool) {
        if animated {
            UIView.transition(with: self.startButton, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.startButton.setTitle(text, for: .normal)
            }, completion: nil)
        } else {
            self.startButton.setTitle(text, for: .normal)
        }
    }
    
    // MARK: Set status label text
    func setStatusText(text: String, animated: Bool) {
        if animated {
            UIView.transition(with: self.startButton, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.statusLabel.text = text
            }, completion: nil)
        } else {
            self.statusLabel.text = text
        }
    }
    
    // MARK: Update session duration label text
    func updateSessionDuration(duration: Int) {
        sessionDuration.text = String(duration)
    }
    
    // MARK: Update session break label text
    func updateBreakDuration(duration: Int) {
        breakDuration.text = String(duration)
    }
    
}
