//
//  ViewController.swift
//  MockImagePickerDemo
//
//  Created by Yonat Sharon on 2018-07-01.
//  Copyright © 2018 Yonat Sharon. All rights reserved.
//

import MockImagePicker
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func showMockCamera() {
        #if targetEnvironment(simulator)
            let picker = MockImagePicker()
        #else
            let picker = UIImagePickerController()
        #endif
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("got image 🖼 with png size=" + (UIImagePNGRepresentation(image)?.count.description ?? "unknown"))
        } else {
            print("no image 😕")
        }

        dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled ❌")
        dismiss(animated: true)
    }
}
