//
//  ThemeSelectionViewController.swift
//  PhotoCollection
//
//  Created by Spencer Curtis on 8/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

protocol ChangeThemeUpdate {
    func updateTheme()
}


class ThemeSelectionViewController: UIViewController {
    
    var themeHelper: ThemeHelper?
    var delegate: ChangeThemeUpdate?
    
    override func viewDidLoad() {
        setUpSubviews()
    }
    
    // MARK: Viewcontroller UI
    func setUpSubviews() {
        // Title Label
        let titleLable = UILabel()
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.text = "Photo Collection"
        titleLable.font = .boldSystemFont(ofSize: 38)
        view.addSubview(titleLable)
        
        titleLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        // Instruction Label
        let instructLabel = UILabel()
        instructLabel.translatesAutoresizingMaskIntoConstraints = false
        instructLabel.text = "Select the color theme to use:"
        
        view.addSubview(instructLabel)
        
        let labelTopConstraint = NSLayoutConstraint(item: instructLabel, attribute: .top, relatedBy: .equal, toItem: titleLable, attribute: .bottom, multiplier: 1, constant: 30)
        let labelCenterXConstraint = NSLayoutConstraint(item: instructLabel, attribute: .centerX, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([labelTopConstraint, labelCenterXConstraint])
        
        // Dark theme button
        let darkButton = UIButton(type: .system)
        darkButton.translatesAutoresizingMaskIntoConstraints = false
        darkButton.setTitle("Dark", for: .normal)
        darkButton.addTarget(self, action: #selector(selectDarkTheme), for: .touchUpInside)
        
        view.addSubview(darkButton)
        
        let darkButtonTopConstraint = NSLayoutConstraint(item: darkButton, attribute: .top, relatedBy: .equal, toItem: instructLabel, attribute: .bottom, multiplier: 1, constant: 40)
        let darkButtonCenterXConstraint = NSLayoutConstraint(item: darkButton, attribute: .centerX, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1, constant: -50)
        
        NSLayoutConstraint.activate([darkButtonTopConstraint, darkButtonCenterXConstraint])
        
        // Blue theme button
        let blueButton = UIButton(type: .system)
        blueButton.translatesAutoresizingMaskIntoConstraints = false
        blueButton.setTitle("Blue", for: .normal)
        blueButton.addTarget(self, action: #selector(selectBlueTheme), for: .touchUpInside)
        
        view.addSubview(blueButton)
        
        let blueButtonCenterYConstraint = NSLayoutConstraint(item: blueButton, attribute: .centerY, relatedBy: .equal, toItem: darkButton, attribute: .centerY, multiplier: 1, constant: 0)
        let blueButtonCenterXConstraint = NSLayoutConstraint(item: blueButton, attribute: .centerX, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1, constant: 50)
        
        NSLayoutConstraint.activate([blueButtonCenterYConstraint, blueButtonCenterXConstraint])
    }

    @objc func selectDarkTheme() {
        themeHelper?.setThemePreferenceToDark()
        delegate?.updateTheme()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func selectBlueTheme() {
        themeHelper?.setThemePreferenceToBlue()
        delegate?.updateTheme()
        dismiss(animated: true, completion: nil)
    }
}
