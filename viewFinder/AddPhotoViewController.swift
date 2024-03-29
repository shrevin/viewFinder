//
//  AddPhotoViewController.swift
//  viewFinder
//
//  Created by Apple on 7/15/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var imagePicker = UIImagePickerController ()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var captionText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //image picker is the object that is created
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
        
    }
    @IBAction func albumsTapped(_ sender: Any) {
        //where to go to pick the image
        imagePicker.sourceType = .savedPhotosAlbum
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func savePhotoTapped(_ sender: UIButton) {
        //the if statement below allows you to access the photo data
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let photoToSave = Photos(entity: Photos.entity(), insertInto: context)
            photoToSave.caption = captionText.text
            
            if let userImage = imageView.image {
                if let userImageData = userImage.pngData(){
                    photoToSave.imageData = userImageData
                }
            }
            
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        //Photos is the name of our core data entity
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //update our photo with selected photo
        if let selectedImage = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {imageView.image = selectedImage}
        //the line above sets the camera picture to whatever the user selects the new image to be
        //go back to our ViewController so the user can see the update
        //the line below takes user back to main screen (since it is a built in funtion)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
