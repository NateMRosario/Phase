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
import MobileCoreServices
import Photos


class CameraViewController: UIViewController {
    
    // !!!WARNING!!! If you are going to use this app you must go into the "Info.plist" file and make sure that the "Privacy - Camera Usage Description", "Privacy - Photo Library Additions Usage Description" & "Privacy - Photo Library Usage Description", as well as their description strings, are set, otherwise you MUST add them. The app WILL NOT WORK! unless you are able to ask for and successfully obtain these three user permissions.
    
    //MARK:- Variables
    
    let cameraView = CameraView()
    let imagePreview = CapturedImageView()
    var images = [PHAsset]()
    let cellSpacing: CGFloat = 2
    var originalPosition = CGFloat()
    let imagePicker = UIImagePickerController()
    
    var captureSession = AVCaptureSession()
    
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    var videoOutput: AVCaptureVideoDataOutput?
    let photoSessionPreset = AVCaptureSession.Preset.photo
    let videoSessionPreset = AVCaptureSession.Preset.medium
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    //var video: AVAsset?
    //let videoURL: String?
    
    //Mark:- ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        view.addSubview(cameraView)
        setupPhotoCaptureSession()
        //setupVideoCaptureSession()
        setupDevices()
        setUpCaptureSessionInput(position: .back)
        setupPreviewLayer()
        startRunningCaptureSession()
        cameraView.photoCollectionView.delegate = self
        cameraView.photoCollectionView.dataSource = self
        imagePicker.delegate = self
        cameraView.shutterButton.addTarget(self,
                                  action: #selector(takePhoto),
                                  for: .touchUpInside
        )
        cameraView.switchCameraButton.addTarget(self,
                                                action: #selector(changeCamera),
                                                for: .touchUpInside)
        cameraView.chooseImageButton.addTarget(self,
                                                action: #selector(chooseImage),
                                                for: .touchUpInside)
        // Here we used dot notation to implement the handle tap function, to the CameraViewController, we created in the extension at the bottom.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CameraViewController.handleTap(_:)))
        tapGestureRecognizer.delegate = self
        tapGestureRecognizer.numberOfTapsRequired = 2
        cameraView.previewLayerContainer.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getImages()
   }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cameraPreviewLayer?.frame = cameraView.previewLayerContainer.bounds
    }
    
    //MARK:- Functions
    // This function lets you access the photos directly from the photo library.
    func getImages() {
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: false)]
        fetchOption.fetchLimit = 20
        images.removeAll()
        print("images removed")
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOption)
        assets.enumerateObjects({ (object, count, stop) in
            self.images.append(object)
        })
        self.cameraView.photoCollectionView.reloadData()
    }
    
    func setupNav() {
        navigationController?.navigationBar.isHidden = true
        
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
    
    // Mark:- @objc functions for buttons
    // This is the function that will be called when the take photo button is pressed.
    @objc func takePhoto(){
        captureSession.beginConfiguration()
        captureSession.sessionPreset = photoSessionPreset
        captureSession.commitConfiguration()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            let settings = AVCapturePhotoSettings()
            self.photoOutput?.capturePhoto(with: settings, delegate: self)
            print("photo taken")
        })
    }
    
    // This function switches the camera and animates the button.
    @objc func changeCamera(sender: UIButton) {
        guard let currentPosition = currentCamera?.position else { return }
        let newPosition: AVCaptureDevice.Position = currentPosition == .back ? .front : .back
        setUpCaptureSessionInput(position: newPosition)
        UIButton.animate(withDuration: 0.3, delay: 0, options: [.curveLinear] ,animations: {
            let rotationAngle = ((180.0 * CGFloat(Double.pi)) / 180.0)
            let newPosition = self.originalPosition + (rotationAngle * -1)
            sender.imageView?.transform = CGAffineTransform(rotationAngle: newPosition)
            self.originalPosition = newPosition
        }, completion: nil)
        print("camera switched")
    }
    
    @objc func chooseImage() {
        let alertController = UIAlertController(title: "Select Image", message: nil , preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let existingPhotoAction = UIAlertAction(title: "Choose from Camera Roll", style: .default) { (alertAction) in
            self.launchCameraFunctions(type: UIImagePickerControllerSourceType.photoLibrary)
        }
        
        alertController.addAction(existingPhotoAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // Mark:- Image picker launch settings.
    private func launchCameraFunctions(type: UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(type){
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = [kUTTypeImage as String]
            
        // Implement this line if you want to use both photos and videos in your image picker.
            //imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Mark:- AVCapture Session Setup functions
    // This function sets up the photo capture session as well as the photo ouput instance and its settings.
    private func setupPhotoCaptureSession(){
        photoOutput = AVCapturePhotoOutput()
        photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        captureSession.addOutput(photoOutput!)
    }
    // Implement this function if you are going to use video in your app.
    private func setupVideoCaptureSession(){
        captureSession.sessionPreset = videoSessionPreset
        
        videoOutput = AVCaptureVideoDataOutput()
        videoOutput?.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String) : NSNumber(value: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange as UInt32)]
        videoOutput?.alwaysDiscardsLateVideoFrames = true
        
        if (captureSession.canAddOutput(videoOutput!) == true) {
            captureSession.addOutput(videoOutput!)
        }
        
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
            previewVC.delegate = self
            present(previewVC, animated: true, completion: nil)
            
        }
    }
}

// Mark:- UIGesture Recognizer Delegate
// This extension is to enable the double tap gesture to switch between front and back camera.
extension CameraViewController: UIGestureRecognizerDelegate {
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
        guard let currentPosition = currentCamera?.position else { return }
        let newPosition: AVCaptureDevice.Position = currentPosition == .back ? .front : .back
        setUpCaptureSessionInput(position: newPosition)
        print("doubletapped")
    }
}

//MARK: UIImagePickerController Delegate & NavigationController Delegate
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage else { print("image is nil"); return }
        //self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];

        self.dismiss(animated: false) {
            self.imagePreview.saveButton.isEnabled = false
            self.image = editedImage
            let cpVC = PreviewViewController(image: self.image!)
            cpVC.delegate = self
            self.present(cpVC, animated: true, completion: nil)}
        
       
        
        // resize the image
//        let sizeOfImage: CGSize = CGSize(width: 300, height: 300)
//        let toucanImage = Toucan.Resize.resizeImage(editedImage, size: sizeOfImage)
//        self.postImage = toucanImage
//        self.newpost.selectImageButton.setImage(postImage, for: .normal)
//        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CameraViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CameraCell
        guard let image = cell.imageView.image else { return }
        
        let ipVC = PreviewViewController(image: image)
        present(ipVC, animated: true, completion: nil)
        print("photo selected")
    }
}

extension CameraViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(images.count, 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cameraView.cameraCellID, for: indexPath) as! CameraCell
       // cell.imageView.image = journeys[indexPath.row]
        let cellHeight = collectionView.frame.height
        let asset = images[indexPath.row]
        let manager = PHImageManager.default()
        if cell.tag != 0 {
            manager.cancelImageRequest(PHImageRequestID(cell.tag))
        }
        cell.tag = Int(manager.requestImage(for: asset,
                                            targetSize: CGSize(width: cellHeight, height: cellHeight),
                                            contentMode: .aspectFill,
                                            options: nil) { (result, _) in
                                                cell.imageView.image = result
        })
        return cell
    }
}

extension CameraViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.frame.height
        return CGSize(width: cellHeight, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}
extension CameraViewController: PreviewVCDelegate {
    func didPost() {
        self.tabBarController?.selectedIndex = 0
//        self.navigationController?.tabBarController?.selectedIndex = 0
    }
}
