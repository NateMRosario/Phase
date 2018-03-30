//
//  CapturedImageView.swift
//  Phase
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class CapturedImageView: UIView {
    
    lazy var cancelButton: UIButton = {
        let cancel = UIButton()
        cancel.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        cancel.layer.opacity = 1
        cancel.layer.cornerRadius = 20
        cancel.layer.masksToBounds = true
        return cancel
    }()
    
    lazy var postButton: UIButton = {
        let post = UIButton()
        post.setTitle("Post", for: .normal)
        post.setTitleColor(.white, for: .normal)
        post.backgroundColor = .clear
        post.layer.borderColor = UIColor.white.cgColor
        post.layer.borderWidth = 1
        post.layer.cornerRadius = 17
        post.layer.masksToBounds = true
        return post
    }()
    
    lazy var headerBackground: UIImageView = {
        let header = UIImageView()
        header.image = #imageLiteral(resourceName: "October Silence")
        header.contentMode = .scaleAspectFill
        header.clipsToBounds = true
        return header
    }()
    
    lazy var headerView: UIView = {
        let header = UIView()
            header.layer.opacity = 0.45
            header.backgroundColor = .white
        return header
    }()
    
    lazy var imagePreviewView: UIImageView = {
        let preview = UIImageView()
        preview.backgroundColor = .black
        preview.contentMode = .scaleAspectFill
        preview.layer.masksToBounds = true
        return preview
    }()
    
    lazy var journeyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Journey"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var postTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.textAlignment = .left
        tv.text = "Insert caption here."
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.black.cgColor
        tv.textColor = .lightGray
        tv.layer.cornerRadius = 6
        tv.layer.masksToBounds = true
        return tv
    }()
    
    lazy var saveButton: UIButton = {
        let save = UIButton()
        save.setImage(#imageLiteral(resourceName: "download"), for: .normal)
        save.backgroundColor = .white
        save.layer.opacity = 0.7
        save.layer.borderColor = UIColor.black.cgColor
        save.layer.borderWidth = 1
        save.layer.cornerRadius = 20
        save.layer.masksToBounds = true
        return save
    }()
    
    let journeyCellID = "Journey Cell"
    let newJourneyCellID = "New Journey"
    
    // MARK: - Lazy variables
    lazy var postCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.register(JourneyCollectionViewCell.self, forCellWithReuseIdentifier: journeyCellID)
        collectionView.register(AddJourneyCollectionViewCell.self, forCellWithReuseIdentifier: newJourneyCellID)
        return collectionView
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .white
        return sv
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .black
        setupViews()
    }
    
    private func setupViews() {
        setupHeaderBackground()
        setupHeaderView()
        setupCancelButton()
        setupPostButton()
        setupPostCollectionView()
        setupScrollView()
        setupContentView()
        setupImagePreviewView()
        setupJourneyLabel()
        setupPostTextView()
        setupSaveButton()
    }
    
    private func setupHeaderBackground() {
        addSubview(headerBackground)
        headerBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerBackground.topAnchor.constraint(equalTo: topAnchor),
            headerBackground.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerBackground.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            headerBackground.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.10),
            headerBackground.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
    }
    
    private func setupHeaderView(){
        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: headerBackground.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: headerBackground.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: headerBackground.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: headerBackground.bottomAnchor),
            headerView.centerXAnchor.constraint(equalTo: headerBackground.centerXAnchor)
            ])
    }
    
    private func setupCancelButton(){
        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            cancelButton.centerYAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.centerYAnchor),
            cancelButton.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.5),
            cancelButton.widthAnchor.constraint(equalTo: cancelButton.heightAnchor, multiplier: 1)
            ])
    }
    
    private func setupPostButton(){
        addSubview(postButton)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postButton.trailingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            postButton.centerYAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.centerYAnchor),
            postButton.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.15)
            ])
    }
    
    private func setupPostCollectionView() {
        addSubview(postCollectionView)
        postCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            postCollectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            postCollectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.2),
            postCollectionView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: postCollectionView.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView.snp.edges)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
    }
    
    private func setupImagePreviewView() {
        contentView.addSubview(imagePreviewView)
        imagePreviewView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagePreviewView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imagePreviewView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            imagePreviewView.heightAnchor.constraint(equalTo: imagePreviewView.widthAnchor),
            imagePreviewView.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor)
            ])
    }

    private func setupJourneyLabel() {
        contentView.addSubview(journeyNameLabel)
        journeyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            journeyNameLabel.topAnchor.constraint(equalTo: imagePreviewView.bottomAnchor, constant: 8),
            journeyNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            journeyNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            journeyNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
    }

    private func setupPostTextView() {
        contentView.addSubview(postTextView)
        postTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postTextView.topAnchor.constraint(equalTo: journeyNameLabel.bottomAnchor, constant: 8),
            postTextView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.96),
            postTextView.heightAnchor.constraint(equalTo: postTextView.widthAnchor, multiplier: 0.24),
            postTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
    }

    private func setupSaveButton() {
        contentView.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 8),
            saveButton.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.1),
            saveButton.heightAnchor.constraint(equalTo: saveButton.widthAnchor, multiplier: 1),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8)
            ])
    }
}
