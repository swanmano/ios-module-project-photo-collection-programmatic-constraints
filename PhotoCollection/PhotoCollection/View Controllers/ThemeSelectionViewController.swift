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
        
        title = "Photo Collection"
        
        let instructLabel = UILabel()
        instructLabel.translatesAutoresizingMaskIntoConstraints = false
        instructLabel.text = "Select the color theme to use:"
        
        view.addSubview(instructLabel)
        
        let labelTopConstraint = NSLayoutConstraint(item: instructLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 30)
        let labelCenterXConstraint = NSLayoutConstraint(item: instructLabel, attribute: .centerX, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([labelTopConstraint, labelCenterXConstraint])
        
        // Dark theme button
        let darkButton = UIButton(type: .system)
        darkButton.translatesAutoresizingMaskIntoConstraints = false
        darkButton.setTitle("Dark", for: .normal)
        darkButton.addTarget(self, action: #selector(selectDarkTheme), for: .touchUpInside)
        
        view.addSubview(darkButton)
        
        let darkButtonTopConstraint = NSLayoutConstraint(item: darkButton, attribute: .top, relatedBy: .equal, toItem: instructLabel, attribute: .bottom, multiplier: 1, constant: 40)
        let darkButtonLeadingConstraint = NSLayoutConstraint(item: darkButton, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50)
        
        NSLayoutConstraint.activate([darkButtonTopConstraint, darkButtonLeadingConstraint])
        
        // Blue theme button
        let blueButton = UIButton(type: .system)
        blueButton.translatesAutoresizingMaskIntoConstraints = false
        blueButton.setTitle("Blue", for: .normal)
        blueButton.addTarget(self, action: #selector(selectBlueTheme), for: .touchUpInside)
        
        view.addSubview(blueButton)
        
        let blueButtonCenterYConstraint = NSLayoutConstraint(item: blueButton, attribute: .centerY, relatedBy: .equal, toItem: darkButton, attribute: .centerY, multiplier: 1, constant: 0)
        let blueButtonTrailingConstraint = NSLayoutConstraint(item: blueButton, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50)
        
        NSLayoutConstraint.activate([blueButtonCenterYConstraint, blueButtonTrailingConstraint])
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
