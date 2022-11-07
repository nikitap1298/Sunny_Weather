//
//  TemperatureCollectionView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 26.08.2022.
//

import UIKit

// MARK: - TemperatureCollectionView
class TemperatureCollectionView: UIView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    private func setUpUI() {
        self.addSubview(collectionView)
        collectionView.translateMask()
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        // Register new custom CollectionViewCell
        collectionView.register(CustomTemperatureCollectionCell.self, forCellWithReuseIdentifier: CustomTemperatureCollectionCell.reuseIdentifier)
        
        // Set new collectionView layout
        collectionView.setCollectionViewLayout(generateTemperatureCollectionLayout(), animated: true)
    }
    
    private func generateTemperatureCollectionLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (section, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(self.collectionView.frame.height))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
            group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    }
    
}

// MARK: - CustomCollectionCell
class CustomTemperatureCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: CustomTemperatureCollectionCell.self)
    
    let mainView = UIView()
    let conditionImage = UIImageView()
    let timeLabel = UILabel()
    let temperatureLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    override func prepareForReuse() {
        conditionImage.image = nil
        timeLabel.text = nil
        temperatureLabel.text = nil
    }
    
    func setUpCollectionCellValues(condImage: UIImage, time: String?, temperature: String) {
        conditionImage.image = condImage
        timeLabel.text = time
        temperatureLabel.text = temperature
    }
    
    private func setUpUI() {
        contentView.addSubview(mainView)
        mainView.addSubview(conditionImage)
        mainView.addSubview(timeLabel)
        mainView.addSubview(temperatureLabel)
        
        mainView.translateMask()
        conditionImage.translateMask()
        timeLabel.translateMask()
        temperatureLabel.translateMask()
        
        mainView.backgroundColor = CustomColors.colorBlue
        mainView.addCornerRadius()
        
        conditionImage.contentMode = .scaleAspectFill
        
        timeLabel.textAlignment = .left
        timeLabel.textColor = CustomColors.colorLightGray
        timeLabel.font = UIFont(name: CustomFonts.loraMedium, size: 12)
        
        temperatureLabel.textAlignment = .left
        temperatureLabel.textColor = CustomColors.colorVanilla
        temperatureLabel.font = UIFont(name: CustomFonts.loraSemiBold, size: 16)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            conditionImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            conditionImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            conditionImage.widthAnchor.constraint(equalToConstant: 25),
            conditionImage.heightAnchor.constraint(equalToConstant: 25),
            
            temperatureLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            temperatureLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            temperatureLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 20),
            
            timeLabel.bottomAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: -30),
            timeLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            timeLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            timeLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
