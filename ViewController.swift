//
//  ViewController.swift
//  MediaCaptureDemo
//
//  Created by Anton Haastrup on 27/03/2020.
//  Copyright © 2020 Anton Haastrup. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var imagePicker  = UIImagePickerController() // Fetches the image from the ios system
    var imageTobeSaved = UIImage()
    
    @IBOutlet weak var textToImage: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faceBookManager?.loginToFacebook()
        imagePicker.delegate = self //assign the this class to handle image picking events
    }

    @IBAction func photoButtonPressed(_ sender: UIButton) {
       
        
        
        
        
        imagePicker.sourceType = .photoLibrary // what type of task camera or photos?
        imagePicker.allowsEditing = true // should editing be allowed?
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    fileprivate func launchCamera() {
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPhotoPressed(_ sender: UIButton) {
        launchCamera()

    }
    @IBAction func videoButtonPressed(_ sender: UIButton) {
        imagePicker.mediaTypes = ["public.movie"] // will launch video
        imagePicker.videoQuality = .typeMedium //set quality of video
        launchCamera()
         }
    
    
    
    
    @IBAction func addTextToimage(_ sender: Any) {
      let s = textToImage.text!
          let s2 = NSAttributedString(string: s, attributes:[.font:UIFont(name: "PartyLetPlain", size: 200)!,
               .foregroundColor: UIColor.green])
          let sz = imageView.image!.size
          let r = UIGraphicsImageRenderer(size:sz)
          imageView.image = r.image {
              _ in
              imageView.image!.draw(at:.zero)
              s2.draw(at: CGPoint(x:40, y:sz.height-200))
          }
      
    }
    
    
    
    
    
    
    @IBAction func saveImageToPhotoRoll(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(imageTobeSaved, nil, nil, nil)
        print("saved to camera roll")
    }
    
   
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print ("returned image")
        // We either  have image or video
        // if video do this:
        if let url = info[.mediaURL] as? URL{ //this will only be true if its a video
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path){
                UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil) //minimal version of save video
            }
            
        }else{ // if we have a image
        
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.image = image
    }
    picker.dismiss(animated: true, completion: nil)

   
        
}
    

}
