//
//  ViewController.swift
//  MockImagePickerDemo
//
//  Created by Yonat Sharon on 2018-07-01.
//  Copyright © 2018 Yonat Sharon. All rights reserved.
//

#if targetEnvironment(simulator)
import MockImagePicker
typealias UIImagePickerController = MockImagePicker
typealias UIImagePickerControllerDelegate = MockImagePickerDelegate
#endif

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func showMockCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            print("got image 🖼 with png size=" + (image.pngData()?.count.description ?? "unknown"))
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
