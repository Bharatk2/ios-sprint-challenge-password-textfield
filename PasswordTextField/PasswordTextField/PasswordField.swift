//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum StrengthPasswordCondtion: String {
    case tooWeak = "Too Weak"
    case medium = "Could be stronger"
    case strong = "Strong Password"
}
class PasswordField: UIControl {
    
    var condition: StrengthPasswordCondtion = .tooWeak
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var textFieldBorderLine: UIView = UIView()
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        titleLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.text = "ENTER YOUR PASSWORD"
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        // Lay out your subviews here
        textField.textContentType = .password
        textField.placeholder = "Write a Password"
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        textFieldBorderLine.translatesAutoresizingMaskIntoConstraints = false
        textFieldBorderLine.layer.borderColor = textFieldBorderColor.cgColor
        textFieldBorderLine.backgroundColor = bgColor
        textFieldBorderLine.layer.borderWidth = 2
        textFieldBorderLine.layer.cornerRadius = 6
        addSubview(textFieldBorderLine)
        
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(changeHideButton), for: .touchUpInside)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(showHideButton)
        
        strongView.layer.backgroundColor = unusedColor.cgColor
        strongView.layer.cornerRadius = 2
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        
        mediumView.layer.backgroundColor = unusedColor.cgColor
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        
        weakView.layer.backgroundColor = weakColor.cgColor
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
        
        strengthDescriptionLabel.text = condition.rawValue
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.font = .systemFont(ofSize: 12)
        addSubview(strengthDescriptionLabel)
        
        //Constraint time!
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        //        Text Field
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //        TextField typing constraints
//        textField.topAnchor.constraint(equalTo: textFieldBorderLine.topAnchor).isActive = true
//        textField.leadingAnchor.constraint(equalTo: textFieldBorderLine.leadingAnchor, constant: 5).isActive = true
//        textField.trailingAnchor.constraint(equalTo: textFieldBorderLine.trailingAnchor, constant: -5).isActive = true
//        textField.heightAnchor.constraint(equalTo: textFieldBorderLine.heightAnchor).isActive = true
//        textField.bottomAnchor.constraint(equalTo: textFieldBorderLine.bottomAnchor, constant: 11).isActive = true
        //        ShowHideButton constraints
        showHideButton.topAnchor.constraint(equalTo: textField.topAnchor).isActive = true
        showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
        
        // Three indicator constraints
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        weakView.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 5).isActive = true
        
        mediumView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 5).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        //        Strength discription constraints
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 10).isActive = true
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc func changeHideButton() {
        textField.isSecureTextEntry.toggle()
        if textField.isSecureTextEntry == true {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
        
        
    }
    
    func passwordStrength(for cases: StrengthPasswordCondtion) {
        condition = cases
        strengthDescriptionLabel.text = condition.rawValue
        
        
        switch cases {
        case .tooWeak:
            
            weakView.layer.backgroundColor = weakColor.cgColor
            mediumView.layer.backgroundColor = unusedColor.cgColor
            strongView.layer.backgroundColor = unusedColor.cgColor
            weakViewAnimate()
        case .medium:
            weakView.layer.backgroundColor = weakColor.cgColor
            mediumView.layer.backgroundColor = mediumColor.cgColor
            strongView.layer.backgroundColor = unusedColor.cgColor
            mediumViewAnimate()
        case .strong:
            weakView.layer.backgroundColor = weakColor.cgColor
            mediumView.layer.backgroundColor = mediumColor.cgColor
            strongView.layer.backgroundColor = strongColor.cgColor
            strongViewAnimate()
        }
        
    }
    
    func determinePasswordStrength(to passwordField: String) {
        var strength: StrengthPasswordCondtion
        
        
        switch passwordField.count {
        case 0...5:
            strength = StrengthPasswordCondtion.tooWeak
            
        case 6...10:
            strength = StrengthPasswordCondtion.medium
        default:
            strength = StrengthPasswordCondtion.strong
        }
        if condition != strength {
            passwordStrength(for: strength)
        }
        
    }
    
    
    private func weakViewAnimate() {
        
        let animationOn = {
            self.weakView.transform = CGAffineTransform(scaleX: 1.6, y: 1.5)
        }
        let animationOff = {
            self.weakView.transform = .identity
        }
        UIView.animate(withDuration: 0.30, animations: {
            animationOn()
        }) { (_) in
            animationOff()
        }
    }
    
    private func mediumViewAnimate() {
        
        let animationOn = {
            self.mediumView.transform = CGAffineTransform(scaleX: 1.2, y: 1.5)
        }
        let animationOff = {
            self.mediumView.transform = .identity
        }
        UIView.animate(withDuration: 0.30, animations: {
            animationOn()
        }) { (_) in
            animationOff()
        }
    }
    
    private func strongViewAnimate() {
        
        let animationOn = {
            self.strongView.transform = CGAffineTransform(scaleX: 1.2, y: 1.5)
        }
        let animationOff = {
            self.strongView.transform = .identity
        }
        UIView.animate(withDuration: 0.30, animations: {
            animationOn()
        }) { (_) in
            animationOff()
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        determinePasswordStrength(to: newText)
        return true
    }
}
