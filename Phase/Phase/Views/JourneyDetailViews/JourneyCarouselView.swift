//
//  JourneyCarouselView.swift
//  Phase
//
//  Created by Clint Mejia on 3/23/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - Custom Delegate
protocol JourneyCarouselViewDelegate: class {
    func showFirstPost()
    func showLastPost()
}


class JourneyCarouselView: UIView {
    
    // Cell Identifier
    let collectionViewCellID = "CarouselCell"
    
    // MARK: - Lazy variables
    lazy var carouselCollectionView: iCarousel = {
        let carousel = iCarousel()
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cellSpacing: CGFloat = 8
        let numberOfCells: CGFloat = 3
        carousel.type = .coverFlow
        carousel.clipsToBounds = true
        carousel.decelerationRate = 0.5
        carousel.bounceDistance = 0.5
        carousel.isPagingEnabled = true
        return carousel
    }()
    
    lazy var carouselSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = UIColor.black
        slider.minimumTrackTintColor = UIColor(hue: 0.5861, saturation: 1, brightness: 0.99, alpha: 1.0) /* #007afe */
        return slider
    }()
    
    lazy var leftDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("45\ndays ago", for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setTitleColor(UIColor.blue, for: .highlighted)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 8, weight: .semibold)
        button.addTarget(self, action: #selector(showFirstPost), for: .touchUpInside)
        return button
    }()
    
    lazy var rightDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("1\ndays ago", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setTitleColor(UIColor.blue, for: .highlighted)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 8, weight: .semibold)
        button.addTarget(self, action: #selector(showLastPost), for: .touchUpInside)
        return button
    }()
    
    lazy var totalCellsInCarouselLabel: PaddingLabel = {
        let label = PaddingLabel(withInsets: 4, 4, 14, 14)
        label.backgroundColor = UIColor.white.withAlphaComponent(1)
        label.text = "1 out of 1"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    
    // MARK: - Delegate
    weak var delegate: JourneyCarouselViewDelegate?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor(hue: 120/360, saturation: 0/100, brightness: 92/100, alpha: 1.0)
        setupViews()
    }
    
    // MARK: - Functions
    private func setupViews() {
        setupCarouselCollectionView()
        setupCarouselSlider()
        setRightDateButtonConstraints()
        setLeftDateButtonConstraints()
        setTotalCellsInCarouselLabelConstraints()
    }
    
    public func configureCarouselSliderButtons(with startDate: NSNumber?, and endDate: NSNumber?) {
        let date = Date()
        self.leftDateButton.setTitle("\(date.timePosted(from: startDate) ?? "0 seconds ago")", for: .normal)
        self.rightDateButton.setTitle("\(date.timePosted(from: endDate) ?? "")", for: .normal)
    }
    
    public func configureCarouselCounter(with events: Int) {
        self.totalCellsInCarouselLabel.text = "total Phases: \(events)"
    }
    
    
    @objc private func showFirstPost() {
        print("showFirstPost")
        delegate?.showFirstPost()
    }
    
    @objc private func showLastPost() {
        print("showFirstPost")
        delegate?.showLastPost()
    }
    
    
    private func setupCarouselCollectionView() {
        addSubview(carouselCollectionView)
        carouselCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.6)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
    }
    
    private func setupCarouselSlider() {
        addSubview(carouselSlider)
        carouselSlider.snp.makeConstraints { (make) in
            make.top.equalTo(carouselCollectionView.snp.bottom).offset(16)
            make.width.equalTo(self).multipliedBy(0.73)
            make.height.equalTo(5)
            make.centerX.equalTo(self)
            
        }
    }
    
    private func setLeftDateButtonConstraints() {
        addSubview(leftDateButton)
        leftDateButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(carouselSlider.snp.leading).offset(-6)
            make.leading.equalTo(self).offset(8)
            make.centerY.equalTo(carouselSlider.snp.centerY)
        }
    }
    
    private func setRightDateButtonConstraints() {
        addSubview(rightDateButton)
        rightDateButton.snp.makeConstraints { (make) in
            make.leading.equalTo(carouselSlider.snp.trailing).offset(6)
            make.centerY.equalTo(carouselSlider.snp.centerY)
            make.trailing.equalTo(self).offset(-8)
        }
    }
    
    private func setTotalCellsInCarouselLabelConstraints() {
        addSubview(totalCellsInCarouselLabel)
        totalCellsInCarouselLabel.snp.makeConstraints { (make) in
            make.top.equalTo(carouselSlider.snp.bottom).offset(16)
            make.centerX.equalTo(carouselSlider.snp.centerX)
        }
    }
    
}
