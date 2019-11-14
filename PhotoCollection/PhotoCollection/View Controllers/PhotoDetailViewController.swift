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
        setUpSubviews()
    }
    
    func setUpSubviews() {
        // Photo
        let displayPhoto = UIImageView()
        displayPhoto.translatesAutoresizingMaskIntoConstraints = false
        displayPhoto.contentMode = .scaleAspectFit
        
        view.addSubview(displayPhoto)
        
        displayPhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        displayPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        displayPhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true
        displayPhoto.widthAnchor.constraint(equalTo: displayPhoto.heightAnchor, multiplier: 1.5).isActive = true
        
        self.imageView = displayPhoto
                
        // Button
        let addImageButton = UIButton(type: .system)
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        addImageButton.setTitle("Add Image", for: .normal)
        addImageButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        
        view.addSubview(addImageButton)
        
        let buttonTopConstraint = addImageButton.topAnchor.constraint(equalTo: displayPhoto.bottomAnchor, constant: 60)
        let buttonCenterXConstrating = addImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        NSLayoutConstraint.activate([buttonTopConstraint, buttonCenterXConstrating])
        
        // Text Field
        let photoName = UITextField()
        photoName.translatesAutoresizingMaskIntoConstraints = false
        photoName.placeholder = "Enter a name for the photo."
        
        view.addSubview(photoName)
        
        let nameTopConstraint = photoName.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 25)
        let nameCenterXConstraint = photoName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        NSLayoutConstraint.activate([nameTopConstraint,nameCenterXConstraint])
        
        self.titleTextField = photoName
        
        // SaveButton
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePhoto))
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
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
                DispatchQueue.main.async {
                self.presentImagePickerController()
                }
            }
        default:
            break
        }
    }
    
    @objc private func savePhoto() {
        
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
