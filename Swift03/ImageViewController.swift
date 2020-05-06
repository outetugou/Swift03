//
//  ImageViewController.swift
//  Swift03
//
//  Created by 王铁刚 on R 2/05/04.
//  Copyright © Reiwa 2 王铁刚. All rights reserved.
//

import UIKit
import AVFoundation

class ImageViewController: UIViewController {

    @IBOutlet weak var shutterBtn: UIButton!
    @IBOutlet weak var previewView: UIView!
    var session = AVCaptureSession()
    var photoOutputObj = AVCapturePhotoOutput()
    let notification = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !session.isRunning else {
            return
        }
        shutterBtn.isEnabled = true
        setupInputOutput()
        setPreviewLayer()
        session.startRunning()
        notification.addObserver(self, selector: #selector(self.changedDeviceOrientatiaon(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        let captureSetting = AVCapturePhotoSettings()
        captureSetting.flashMode = .auto
        //captureSetting.isAutoStillImageStabilizationEnabled = true
        captureSetting.isHighResolutionPhotoEnabled = false
        photoOutputObj.capturePhoto(with: captureSetting, delegate: self)
    }
    
    func setupInputOutput() {
        session.sessionPreset = AVCaptureSession.Preset.photo
        do {
            let device = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: AVCaptureDevice.Position.back)
            //let device = AVCaptureDevice.default(for: AVMediaType.video)
            let input = try AVCaptureDeviceInput(device: device!)
            if session.canAddInput(input) {
                session.addInput(input)
            } else {
                print("sessionに入力を追加できなかった")
                return
            }
        } catch let error as NSError {
            print("カメラが使えない \n \(error.description)")
            showAlert(appName: "カメラ")
            return
        }
        
        if session.canAddOutput(photoOutputObj) {
            session.addOutput(photoOutputObj)
        } else {
            print("sessionに出力を追加できなかった")
        }
    }

    func showAlert(appName: String) {
        let aTitle = appName + "のプライバシー認証"
        let aMessage = "設定＞プライバシー" + appName + "で利用を許可してください。"
        let alert = UIAlertController(title: aTitle, message: aMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "許可しないa", style: .default, handler: { (action) in
            self.shutterBtn.isEnabled = false
        }))
        alert.addAction(UIAlertAction(title: "設定を開く", style: .default, handler: { (action) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }))
        self.present(alert, animated: false, completion: nil)
    }
    
    func setPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        previewLayer.masksToBounds = true
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        previewView.layer.addSublayer(previewLayer)
    }
    
    @objc func changedDeviceOrientatiaon(_ notifi: Notification) {
        if let photoOutputConnection = self.photoOutputObj.connection(with: AVMediaType.video) {
            switch UIDevice.current.orientation {
            case .portrait:
                photoOutputConnection.videoOrientation = .portrait
            case .portraitUpsideDown:
                photoOutputConnection.videoOrientation = .portraitUpsideDown
            case .landscapeLeft:
                photoOutputConnection.videoOrientation = .landscapeRight
            case .landscapeRight:
                photoOutputConnection.videoOrientation = .landscapeLeft
            default:
                break
            }
        }
    }
}
