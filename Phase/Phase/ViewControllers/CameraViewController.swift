//
//  CameraViewController.swift
//  Phase
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
// You NEED! to import AVFoundation in order to use the "AV" methods.
import AVFoundation

class CameraViewController: UIViewController {
    
    // !!!WARNING!!! If you are going to use this app you must go into the "Info.plist" file and make sure that the "Privacy - Camera Usage Description" & "Privacy - Photo Library Additions Usage Description", as well as their description strings, are set, otherwise you MUST add them. The app WILL NOT WORK! unless you are able to ask for and successfully obtain these two user permissions.
    
    //MARK:- Variables
    
    let cameraView = CameraView()
    var originalPosition = CGFloat()
    
    var captureSession = AVCaptureSession()
    
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    
    //Mark:- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupCaptureSession()
        view.addSubview(cameraView)
        setupDevices()
        setUpCaptureSessionInput(position: .back)
        setupPreviewLayer()
        startRunningCaptureSession()
        cameraView.shutterButton.addTarget(self,
                                  action: #selector(takePhoto),
                                  for: .touchUpInside
        )
        cameraView.switchCamera.addTarget(self, action: #selector(changeCamera), for: .touchUpInside)
        
        // Here we used dot notation to implement the handle tap function, to the CameraViewController, we created in the extension at the bottom.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CameraViewController.handleTap(_:)))
        tapGestureRecognizer.delegate = self
        tapGestureRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cameraPreviewLayer?.frame = cameraView.previewLayerContainer.bounds
    }
    
    //MARK:- Functions
    func setupNav() {
        let newJourneyButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewJourney(_:)))
        self.navigationItem.rightBarButtonItem = newJourneyButton
    }
    
    @objc func addNewJourney(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(NewPostViewController.instantiate(withStoryboard: "NewPost"), animated: true)
    }
    
    // This function sets up a switch to change the camera in use depending on current position when called.
    private func setUpCaptureSessionInput(position: AVCaptureDevice.Position) {
        switch position {
        case .back:
            currentCamera = backCamera
        case .front:
            currentCamera = frontCamera
        default:
            currentCamera = backCamera
        }
        
        setupInputOutput()
    }
    
    // This is the function that will be called when the take photo button is pressed.
    @objc func takePhoto(){
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    // This function switches the camera and animates the button.
    @objc func changeCamera(sender: UIButton) {
        guard let currentPosition = currentCamera?.position else { return }
        let newPosition: AVCaptureDevice.Position = currentPosition == .back ? .front : .back
        setUpCaptureSessionInput(position: newPosition)
        UIButton.animate(withDuration: 0.3, delay: 0, options: [.curveLinear] ,animations: {
            let rotationAngle = ((180.0 * CGFloat(Double.pi)) / 180.0)
            let newPosition = self.originalPosition + rotationAngle
            sender.imageView?.transform = CGAffineTransform(rotationAngle: newPosition)
            self.originalPosition = newPosition
        }, completion: nil)
        print("camera switched")
    }

    // This function sets up the capture session as well as the photo ouput instance and its settings.
    private func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        photoOutput = AVCapturePhotoOutput()
        photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        captureSession.addOutput(photoOutput!)
    }
    
    // This function allows you to have the application discover the devices camera(s)
    private func setupDevices(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
    }
    
    // This function allows you to remove the current camera input in use and to set and enable a new camera input.
    private func setupInputOutput(){
        captureSession.beginConfiguration()
        if let currentInput = captureSession.inputs.first {
            captureSession.removeInput(currentInput)
        }
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print(error)
        }
        captureSession.commitConfiguration()
    }
    
    // This function creates a layer in the view that will enable a live feed of what your camera is observing.
    private func setupPreviewLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraView.previewLayerContainer.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    // Starts running the capture session after you set up the view.
    private func startRunningCaptureSession(){
        captureSession.startRunning()
    }
    
}

//MARK:- Extensions
// This extension is used because you need to wait until the photo you took "didFinishProcessing" before you can handle the image.
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            print(imageData)
            image = UIImage(data: imageData)
            guard let image = image else { return }
            let previewVC = PreviewViewController(image: image)
            present(previewVC, animated: true, completion: nil)
            
        }
    }
}

// This extension is to enable the double tap gesture to switch between front and back camera.
extension CameraViewController: UIGestureRecognizerDelegate {
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
        guard let currentPosition = currentCamera?.position else { return }
        let newPosition: AVCaptureDevice.Position = currentPosition == .back ? .front : .back
        setUpCaptureSessionInput(position: newPosition)
        print("doubletapped")
    }
}
