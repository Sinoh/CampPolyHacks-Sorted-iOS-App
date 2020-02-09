//
//  ViewController.swift
//  Recycle
//
//  Created by Jeffery Ho on 2/8/20.
//  Copyright © 2020 SLOWip. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // here is where we start up the camera
        
        let captureSesssion = AVCaptureSession()
        captureSesssion.sessionPreset = .photo
        
        guard let captureDevice =
            AVCaptureDevice.default(for: .video) else {return}
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {return}
        
        captureSesssion.addInput(input)
        captureSesssion.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSesssion)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
    }
}

