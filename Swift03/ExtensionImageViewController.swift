//
//  ExtensionImageViewController.swift
//  Swift03
//
//  Created by 王铁刚 on R 2/05/04.
//  Copyright © Reiwa 2 王铁刚. All rights reserved.
//

import UIKit
import Photos

extension ImageViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let photoData = photo.fileDataRepresentation() else {
            return
        }
        if let stillImage = UIImage(data: photoData) {
            UIImageWriteToSavedPhotosAlbum(stillImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alert = UIAlertController(title: "アルバムへの追加エラーですよ", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
            }))
            
        } else {
            print("アルバムへの追加成功ですよ")
        }
    }
}
