//
//  ViewController.swift
//  Recycle
//
//  Created by Jeffery Ho on 2/8/20.
//  Copyright © 2020 SLOWip. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    let captureSession = AVCaptureSession()
    var previewLayer:CALayer!
    
    var captureDevice:AVCaptureDevice!
    
    var takePhoto = false
    
    // Sent from server to phone
    var isRecycleable = false
    var labels = [String]()
    
    override func viewDidLoad() {
        super.viewWillDisappear(false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            previewLayer.videoGravity = .resizeAspectFill
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
                DispatchQueue.main.async {
                    
                    if  self.labels.contains("plastic bottle"){
                        let bottleVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BottleVC") as! BottleViewController
                        self.present(bottleVC, animated: true, completion: nil) //{self.stopCaptureSession()})
                    } else if self.labels.contains("tin can") {
                        let photoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoVC") as! PhotoViewController
                        self.present(photoVC, animated: true, completion: nil) //{self.stopCaptureSession()})
                    } else {
                        let trashVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrashVC") as! TrashViewController
                        self.present(trashVC, animated: true, completion: nil) //{self.stopCaptureSession()})
                    }
                    
                    
                    self.callRestAPI(image)
                }
            }
        }
    }
    

    // Convert CIImage to CGImage
    func convert(cmage:CIImage) -> UIImage
    {
         let context:CIContext = CIContext.init(options: nil)
         let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
         let image:UIImage = UIImage.init(cgImage: cgImage)
         return image
    }

    func getImageFromSampleBuffer (buffer:CMSampleBuffer) -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
            }
            
        }
        return nil
    }
    
    func stopCaptureSession () {
        self.captureSession.stopRunning()
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                self.captureSession.removeInput(input)
            }
        }
        
    }
    
    func callRestAPI(_ image:UIImage) {
        var getUrl : String = "http://justinnuwin.com:8000/label?location="
        // Call function to get GPS coordinate in <lat,long> format
        getUrl.append("123.123,456.456")
        let request = NSMutableURLRequest(url: NSURL(string: getUrl)! as URL)
        let session = URLSession.shared
        request.addValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = image.jpegData(compressionQuality: 50)

        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            let dataString = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)
            print("Response: \(String(describing: dataString))")
           
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                // try to read out a string array
                self.labels = json["labels"] as! [String]
                print(self.labels)
            
                self.isRecycleable = ((json["isRecycleable"] as? Bool) != nil)
                print(self.isRecycleable)
            } catch {}

        })
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

