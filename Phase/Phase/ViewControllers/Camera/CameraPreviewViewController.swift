//
//  CameraPreviewViewController.swift
//  Phase
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    public let imagePreview = CapturedImageView()
    
    let cellSpacing: CGFloat = 1
    
    var journeys = [Journey]() {
        didSet {
            DispatchQueue.main.async {
                
                self.journeys = self.journeys.sorted{ $0._creationDate as! Double > $1._creationDate as! Double }
                self.imagePreview.postCollectionView.reloadData()
            }
        }
    }
    
    var journeyIds = [String]() {
        didSet {
            DynamoDBManager.shared.loadJourney(journeyId: journeyIds.last!, completion: { (journey, error) in
                if let journey = journey {
                    self.journeys.append(journey)
                } else if let error = error {
                    print(error)
                }
            })
        }
    }
    
    public var image: UIImage!
    
    var selectedIndexPath: IndexPath!
    var selectedJourney: Journey!
    
    //var mediaType: MediaType
    
    let addNewJourneyDelegate = AddJourneyViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewJourneyDelegate.delegate = self
        view.addSubview(imagePreview)
        self.imagePreview.postCollectionView.delegate = self
        self.imagePreview.postCollectionView.dataSource = self
        self.imagePreview.postTextView.delegate = self
        addObservers()
        imagePreview.postTextView.delegate = self
        imagePreview.cancelButton.addTarget(self,
                                            action: #selector(cancel),
                                            for: .touchUpInside
        )
        imagePreview.saveButton.addTarget(self,
                                          action: #selector(save),
                                          for: .touchUpInside)
        imagePreview.postButton.addTarget(self,
                                          action: #selector(post),
                                          for: .touchUpInside
        )
        
        imagePreview.imagePreviewView.image = image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getJourneys()

    }
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getJourneys() {
        let userID = CognitoManager.shared.userId!
        DynamoDBManager.shared.loadUser(userId: userID) { (appUser, error) in
            if let error = error {
                print(error)
            } else if let appUser = appUser {
                guard let journeyIDs = appUser._journeys else { return }
                for journey in journeyIDs {
                    if !self.journeyIds.contains(journey) {
                    self.journeyIds.append(journey)
                    }

            }
        }
        
    }
    }
  
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let scrollView = self.imagePreview.scrollView
            scrollView.contentInset.bottom = keyboardSize.size.height
            scrollView.scrollIndicatorInsets.bottom = keyboardSize.size.height
            scrollView.scrollRectToVisible(imagePreview.saveButton.frame, animated: true)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        let scrollView = self.imagePreview.scrollView
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }
    
    @objc func cancel(){
        imagePreview.saveButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    @objc func post(){
        let caption = imagePreview.postTextView.text ?? " "
        
        
        DynamoDBManager.shared.createEvent(journey: selectedJourney, image: image, caption: caption) { (error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Error creating event: \(error)")
                }
            } else {
                
            }
        }
    }
    
    @objc func save(sender: UIButton){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        UIButton.animate(withDuration: 0.2, animations: {
            sender.alpha = 0.0
        }, completion:{(finished) in
            self.imagePreview.saveButton.setImage(UIImage(named: "saved"), for: .normal)
            self.imagePreview.saveButton.backgroundColor = UIColor(white: 1, alpha: 0.7)
            self.imagePreview.saveButton.layer.borderColor = UIColor.black.cgColor
            self.imagePreview.saveButton.layer.borderWidth = 1
            self.imagePreview.saveButton.layer.cornerRadius = 20
            self.imagePreview.saveButton.layer.masksToBounds = true
            UIView.animate(withDuration: 0.2,animations:{
                sender.alpha = 1.0
            },completion:nil)
        })
        imagePreview.saveButton.isEnabled = false
        print("photo saved")
    }
}

extension PreviewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            selectedIndexPath = nil
//        } else if selectedIndexPath == nil {
//            selectedIndexPath = indexPath
//        } else {
//            // MARK: - PHONY
//            let previousCell =  collectionView.cellForItem(at: selectedIndexPath) as! JourneyCollectionViewCell
//            previousCell.selectedJourneyLayer.isHidden = true
//            selectedIndexPath = indexPath
//        }
        
//        selectedJourney = journeys[indexPath.row - 1]
        
        if indexPath.row == 0 {
            let cell = collectionView.cellForItem(at: indexPath) as! AddJourneyCollectionViewCell
            let njVC = AddJourneyViewController()
            present(njVC, animated: true, completion: nil)
            print("add journey cell selected")
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! JourneyCollectionViewCell
            selectedJourney = cell.journey!
            if cell.selectedJourneyLayer.isHidden == true {
                cell.state = .selected
                cell.selectedJourneyLayer.isHidden = false
            } else {
                cell.state = .notSelected
                cell.selectedJourneyLayer.isHidden = true
            }
            imagePreview.journeyNameLabel.text = cell.journeyNameLabel.text
        }
    }
}

extension PreviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return journeys.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Make sure first journey is on indexpath.row = 1
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagePreview.newJourneyCellID, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagePreview.journeyCellID, for: indexPath) as! JourneyCollectionViewCell
            if cell.state == .selected {
                cell.selectedJourneyLayer.isHidden = false
            } else {
                cell.selectedJourneyLayer.isHidden = true
            }
//            cell.journeyImageView.image = journeys[indexPath.row - 1]
            let journey = journeys[indexPath.row - 1]
            cell.journey = journey
            cell.journeyNameLabel.text = journey._title
            return cell
        }
    }
}

extension PreviewViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 4
        let numSpaces: CGFloat = numCells + 1
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.19)
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

extension PreviewViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        let currentText = textView.text ?? "CHANGE LATER"
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= 120 // Pass your character count here
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        imagePreview.postTextView.text = "CHANGE LATER"
        imagePreview.postTextView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        imagePreview.postTextView.resignFirstResponder()
    }
}

extension PreviewViewController: AddNewJourneyViewDelegate {
    func createdNewJourney() {
        // SET COLLECTIONVIEW CELL
    }
}

