//
//  ViewController.swift
//  Recycle
//
//  Created by Jeffery Ho on 2/8/20.
//  Copyright © 2020 SLOWip. All rights reserved.
//

import UIKit
//import AVKit
import AVFoundation
/*
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // here is where we start up the camera
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice =
            AVCaptureDevice.default(for: .video) else {return}
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {return}
        
        captureSession.addInput(input)
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        
        let dataOutput = AVCaptureVideoDataOutput()
        
        dataOutput.videoSettings = [((kCVPixelBufferPixelFormatTypeKey as NSString) as String): NSNumber(value: kCVPixelFormatType_30RGB)]
        
        
        dataOutput.alwaysDiscardsLateVideoFrames = true
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        
        captureSession.commitConfiguration()

    }
}
 */



class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    let captureSession = AVCaptureSession()
    var previewLayer:CALayer!
    
    var captureDevice:AVCaptureDevice!
    
    var takePhoto = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCamera()
    }
    
    func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        }catch {
            print(error.localizedDescription)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            self.previewLayer = previewLayer
            self.view.layer.addSublayer(self.previewLayer)
            self.previewLayer.frame = self.view.layer.frame
            captureSession.startRunning()
            
        
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.videoSettings = [((kCVPixelBufferPixelFormatTypeKey as NSString) as String): NSNumber(value: kCVPixelFormatType_32BGRA)]
            
            dataOutput.alwaysDiscardsLateVideoFrames = true
            if captureSession.canAddOutput(dataOutput) {
                captureSession.addOutput(dataOutput)
            }
            
            
            captureSession.commitConfiguration()
              
            let queue = DispatchQueue (label: "CampPolyHacks.Recycle")
            dataOutput.setSampleBufferDelegate(self, queue: queue)
        
            
        
    }
    
    func prepareCamera() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        /*if let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices {
            captureDevice = availableDevices.first
            beginSession()
         
             }
         }*/
        
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
            captureDevice = availableDevices.first
            beginSession()
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        takePhoto = true
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if takePhoto {
            takePhoto = false
            if let image = self.getImageFromSampleBuffer(buffer: sampleBuffer) {
                
                let photoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoVC") as! PhotoViewController
                photoVC.takenPhoto = image
                
                DispatchQueue.main.async {
                    self.present(photoVC, animated: true, completion: nil)
                }
            }
        }
    }

    func getImageFromSampleBuffer (buffer:CMSampleBuffer) -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height:  CVPixelBufferGetHeight(pixelBuffer))
            
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
            }
        }
        return nil
    }

}
