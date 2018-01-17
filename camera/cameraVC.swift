//
//  cameraVC.swift
//  tickMe
//
//  Created by donezio on 11/14/17.
//  Copyright © 2017 macbook pro. All rights reserved.
// https://www.youtube.com/watch?v=Zv4cJf5qdu0
// https://www.youtube.com/watch?v=-O8WBZNIAN8
// https://www.youtube.com/watch?v=7TqXrMnfJy8

import UIKit
import AVFoundation

class cameraVC: UIViewController,AVCapturePhotoCaptureDelegate {

    var captureSession = AVCaptureSession()
    var backCamera : AVCaptureDevice?
    var frontCamera : AVCaptureDevice? //change camera in setupDevice
    var currentCamera : AVCaptureDevice?
    var photoOutput : AVCapturePhotoOutput?
    
    var image : UIImage?
    
    var cameraPreviewLayer : AVCaptureVideoPreviewLayer?
   
    @IBAction func takePhoto(_ sender: Any) {
        //performSegue(withIdentifier: "previewPhoto", sender: nil)
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
      
    }
    
    // image quality and resolution
    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    // create device
    func setupDevice(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position:      AVCaptureDevice.Position.back)
        
        let devices = deviceDiscoverySession.devices
        
        for device in devices{
            if device.position == AVCaptureDevice.Position.back{
                backCamera = device
            }
            currentCamera = backCamera
        }
        
    }
    
    //connect device to capture session
    func setupInputOutput(){
        do{
            let captureDeviceInput = try AVCaptureDeviceInput(device : currentCamera!)
            captureSession.addInput((captureDeviceInput))
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format:[AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch{
             print(error)
        }
    }
    // preview layer
    func setupPreviewLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session : captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession(){
        captureSession.startRunning()
    }
    
    override func prepare(for segue : UIStoryboardSegue, sender : Any?){
        if segue.identifier == "previewPhoto" {
            let previewVC = segue.destination as! previewPhotoViewController
            previewVC.image = self.image
        }
    }
    
    public func photoOutput(_ output : AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error : Error?){
        if let imageData = photo.fileDataRepresentation(){
            print(imageData)
            image = UIImage(data : imageData)
            performSegue(withIdentifier: "previewPhoto", sender: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}







