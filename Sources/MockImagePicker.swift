//
//  MockImagePicker.swift
//  Mock UIImagePickerController for use in simulator.
//
//  Created by Yonat Sharon on 2018-07-01.
//  Copyright © 2018 Yonat Sharon. All rights reserved.
//

import MobileCoreServices
import SweeterSwift
import UIKit

@objc public protocol MockImagePickerDelegate {
    @objc optional func imagePickerController(_ picker: MockImagePicker, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    @objc optional func imagePickerControllerDidCancel(_ picker: MockImagePicker)
}

open class MockImagePicker: UINavigationController {
    public typealias InfoKey = UIImagePickerController.InfoKey

    @objc open class func availableMediaTypes(for sourceType: UIImagePickerController.SourceType) -> [String]? {
        return []
    }

    @objc open class func isSourceTypeAvailable(_ sourceType: UIImagePickerController.SourceType) -> Bool {
        return sourceType == .camera ? true : false
    }

    @objc open class func isCameraDeviceAvailable(_ cameraDevice: UIImagePickerController.CameraDevice) -> Bool {
        return true
    }

    @objc open var cameraDevice: UIImagePickerController.CameraDevice = .rear
    @objc open var sourceType: UIImagePickerController.SourceType = .camera
    @objc open var mediaTypes: [String] = [kUTTypeImage as String]
    @objc open var allowsEditing: Bool = true
    @objc open var showsCameraControls: Bool {
        get {
            return mockCamera.showsCameraControls
        }
        set {
            mockCamera.showsCameraControls = newValue
        }
    }

    @objc open func takePicture() {
        mockCamera.showsCameraControls = false
        let info: [UIImagePickerController.InfoKey: Any]
        if let image = mockCamera.imageView.image {
            info = [.originalImage: image]
        } else {
            info = [:]
        }
        (delegate as? MockImagePickerDelegate)?.imagePickerController?(self, didFinishPickingMediaWithInfo: info)
    }

    @objc open func cancel() {
        mockCamera.showsCameraControls = false
        (delegate as? MockImagePickerDelegate)?.imagePickerControllerDidCancel?(self)
    }

    lazy var mockCamera = MockCameraViewController(owner: self)

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        isNavigationBarHidden = true
        viewControllers = [mockCamera]
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .fullScreen
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
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
        takePictureButton.layoutMargins = .zero
        // swiftlint:disable:next numbers_smell
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
