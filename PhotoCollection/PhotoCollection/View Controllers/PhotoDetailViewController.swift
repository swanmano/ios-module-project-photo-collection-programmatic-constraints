//
//  PhotoDetailViewController.swift
//  PhotoCollection
//
//  Created by Spencer Curtis on 8/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import Photos

class PhotoDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageView: UIImageView!
    var titleTextField: UITextField!
    
    var photo: Photo?
    var photoController: PhotoController?
    var themeHelper: ThemeHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTheme()
        updateViews()
    }
    
    func setUpSubviews() {
        // Photo
        let displayPhoto = UIImageView()
        displayPhoto.translatesAutoresizingMaskIntoConstraints = false
        displayPhoto.contentMode = .scaleAspectFit
        
        view.addSubview(displayPhoto)
        
        let photoTopConstraint = displayPhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 60)
        let photoCenterXConstraint = displayPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        let photoHeightConstraint = displayPhoto.heightAnchor.constraint(equalToConstant: 150)
        let photoWidthConstraint = displayPhoto.widthAnchor.constraint(equalTo: displayPhoto.heightAnchor, multiplier: 1.5)
        
        NSLayoutConstraint.activate([photoTopConstraint, photoCenterXConstraint, photoHeightConstraint, photoWidthConstraint])
        
        // Button
        let addImageButton = UIButton(type: .system)
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        addImageButton.setTitle("Add Image", for: .normal)
        addImageButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        
        view.addSubview(addImageButton)
        
        let buttonTopConstraint = addImageButton.topAnchor.constraint(equalTo: displayPhoto.bottomAnchor, constant: 60)
        let buttonCenterXConstrating = addImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        
        NSLayoutConstraint.activate([buttonTopConstraint, buttonCenterXConstrating])
        
        // Text Field
        let photoName = UITextField()
        photoName.translatesAutoresizingMaskIntoConstraints = false
        photoName.placeholder = "Enter a name for the photo."
        
        view.addSubview(photoName)
        
        let nameTopConstraint = photoName.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 25)
        let nameCenterXConstraint = photoName.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        let nameLeadingConstraint = photoName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        let nameTrailingConstraint = photoName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 30)
        
        NSLayoutConstraint.activate([nameTopConstraint, nameCenterXConstraint, nameLeadingConstraint, nameTrailingConstraint])
        
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        imageView.image = image
    }
    
    // MARK: - Private Methods
    
    @objc private func addImage() {
        
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
    
        switch authorizationStatus {
        case .authorized:
            presentImagePickerController()
            
        case .notDetermined:
            
            PHPhotoLibrary.requestAuthorization { (status) in
                
                guard status == .authorized else {
                    NSLog("User did not authorize access to the photo library")
                    return
                }
                self.presentImagePickerController()
            }
        default:
            break
        }
    }
    
    private func savePhoto() {
        
        guard let image = imageView.image,
            let imageData = image.pngData(),
            let title = titleTextField.text else { return }
        
        if let photo = photo {
            photoController?.update(photo: photo, with: imageData, and: title)
        } else {
            photoController?.createPhoto(with: imageData, title: title)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        
        guard let photo = photo else {
            title = "Create Photo"
            return
        }
        
        title = photo.title
        
        imageView.image = UIImage(data: photo.imageData)
        titleTextField.text = photo.title
    }
    
    private func presentImagePickerController() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func setTheme() {
        guard let themePreference = themeHelper?.themePreference else { return }
        
        var backgroundColor: UIColor!
        
        switch themePreference {
        case "Dark":
            backgroundColor = .lightGray
        case "Blue":
            backgroundColor = UIColor(red: 61/255, green: 172/255, blue: 247/255, alpha: 1)
        default:
            break
        }
        
        view.backgroundColor = backgroundColor
    }
}
