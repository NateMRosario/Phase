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
    
    var journeys = [#imageLiteral(resourceName: "a"),#imageLiteral(resourceName: "b"),#imageLiteral(resourceName: "c"),#imageLiteral(resourceName: "d"),#imageLiteral(resourceName: "e"),#imageLiteral(resourceName: "f"),#imageLiteral(resourceName: "g"),#imageLiteral(resourceName: "h")]
    
    public var image: UIImage!
    
    //var mediaType: MediaType
    
    let addNewJourneyDelegate = AddJourneyViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewJourneyDelegate.delegate = self
        view.addSubview(imagePreview)
        self.imagePreview.postCollectionView.delegate = self
        self.imagePreview.postCollectionView.dataSource = self
        self.imagePreview.postTextView.delegate = self
        imagePreview.cancelButton.addTarget(self,
                                            action: #selector(cancel),
                                            for: .touchUpInside
        )
        imagePreview.saveButton.addTarget(self,
                             action: #selector(save),
                             for: .touchUpInside)
//        imagePreview.postButton.addTarget(self,
//                                         action: #selector(post),
//                                         for: .touchUpInside
//        )

        imagePreview.imagePreviewView.image = image
    }
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cancel(){
        imagePreview.saveButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
//    @objc func post(){
//        imagePreview.saveButton.isEnabled = true
//        let cpVC = NewPostViewController(image: image)
//        present(cpVC, animated: true, completion: nil)
//    }
    
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
        guard indexPath.row == 0 else { return }
        let cell = collectionView.cellForItem(at: indexPath) as! AddJourneyCollectionViewCell
        let njVC = AddJourneyViewController()
        present(njVC, animated: true, completion: nil)
        print("add journey cell selected")
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
            cell.journeyImageView.image = journeys[indexPath.row - 1]
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
    func textViewDidBeginEditing(_ textView: UITextView) {
        imagePreview.postTextView.text = ""
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
