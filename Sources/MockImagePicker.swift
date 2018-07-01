//
//  MockImagePicker.swift
//  Mock UIImagePickerController for use in simulator.
//
//  Created by Yonat Sharon on 2018-07-01.
//  Copyright © 2018 Yonat Sharon. All rights reserved.
//

import MiniLayout
import MobileCoreServices
import UIKit

open class MockImagePicker: UINavigationController {
    open class func availableMediaTypes(for sourceType: UIImagePickerControllerSourceType) -> [String]? {
        return []
    }

    open class func isSourceTypeAvailable(_ sourceType: UIImagePickerControllerSourceType) -> Bool {
        return sourceType == .camera ? true : false
    }

    open class func isCameraDeviceAvailable(_ cameraDevice: UIImagePickerControllerCameraDevice) -> Bool {
        return true
    }

    open var cameraDevice: UIImagePickerControllerCameraDevice = .rear
    open var sourceType: UIImagePickerControllerSourceType = .camera
    open var mediaTypes: [String] = [kUTTypeImage as String]
    open var allowsEditing: Bool = true
    open var showsCameraControls: Bool {
        get {
            return mockCamera.showsCameraControls
        }
        set {
            mockCamera.showsCameraControls = newValue
        }
    }

    @objc open func takePicture() {
        mockCamera.showsCameraControls = false
        let info: [String: Any]
        if let image = mockCamera.imageView.image {
            info = [UIImagePickerControllerOriginalImage: image]
        } else {
            info = [:]
        }
        (delegate as? UIImagePickerControllerDelegate)?.imagePickerController?(UIImagePickerController(), didFinishPickingMediaWithInfo: info)
    }

    @objc open func cancel() {
        mockCamera.showsCameraControls = false
        (delegate as? UIImagePickerControllerDelegate)?.imagePickerControllerDidCancel?(UIImagePickerController())
    }

    lazy var mockCamera = MockCameraViewController(owner: self)

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        isNavigationBarHidden = true
        viewControllers = [mockCamera]
    }
}

class MockCameraViewController: UIViewController {
    let imageView = UIImageView()
    let cancelButton = UIButton()
    let takePictureButton = UIButton()

    var showsCameraControls: Bool = true {
        didSet {
            for control in [cancelButton, takePictureButton] {
                control.isHidden = !showsCameraControls
            }
        }
    }

    weak var owner: MockImagePicker?

    convenience init(owner: MockImagePicker) {
        self.init()
        self.owner = owner
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        view.addConstrainedSubview(imageView, constrain: .top, .bottom, .right, .left)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.random()

        view.addConstrainedSubview(takePictureButton, constrain: .centerX, .bottomMargin)
        let takePhotoSymbol = NSAttributedString(string: "◉", attributes: [.font: UIFont.systemFont(ofSize: 64), .foregroundColor: UIColor.white])
        takePictureButton.setAttributedTitle(takePhotoSymbol, for: .normal)
        takePictureButton.addTarget(owner, action: #selector(MockImagePicker.takePicture), for: .touchUpInside)

        view.addConstrainedSubview(cancelButton, constrain: .leftMargin)
        view.constrain(cancelButton, at: .centerY, to: takePictureButton)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(owner, action: #selector(MockImagePicker.cancel), for: .touchUpInside)
    }
}

extension UIImage {
    static func random() -> UIImage? {
        let urlString = String(
            format: "https://www.gravatar.com/avatar/%04x%04x%04x%04x?d=monsterid&s=480",
            arc4random(), arc4random(), arc4random(), arc4random()
        )
        guard let url = URL(string: urlString) else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: imageData)
    }
}
