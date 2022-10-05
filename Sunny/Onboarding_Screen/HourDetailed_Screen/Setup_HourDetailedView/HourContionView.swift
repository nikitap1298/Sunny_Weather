//
//  DetailedContionView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 28.08.2022.
//

import UIKit

// MARK: - DetailedConditionView
class HourConditionView: UIView {
    
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
        collectionView.isScrollEnabled = true
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        // Register new custom CollectionViewCell
        collectionView.register(DetailedConditionCell.self, forCellWithReuseIdentifier: DetailedConditionCell.reuseIdentifier)
        
        // Set new collectionView layout
        collectionView.setCollectionViewLayout(generateDetailedConditionLayout(), animated: true)
    }
    
    private func generateDetailedConditionLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (section, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = .init(top: 0, leading: 5, bottom: 15, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(self.collectionView.frame.height / 2))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}

// MARK: - DetailedConditionCell
class DetailedConditionCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: DetailedConditionCell.self)
    
    let stackView = UIStackView()
    let parameterNameLabel = UILabel()
    let parameterValueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    override func prepareForReuse() {
        parameterNameLabel.text = nil
        parameterValueLabel.text = nil
    }
    
    func setUpParameterName(_ name: String) {
        parameterNameLabel.text = name
    }
    
    func setUpParameterValue(_ value: String) {
        parameterValueLabel.text = value
    }
    
    private func setUpUI() {
        self.addSubview(stackView)
        
        stackView.translateMask()
       
        stackView.backgroundColor = UIColor(named: CustomColors.colorDarkBlue)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.addCornerRadius()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        addLabelsToStackView()
    }
    
    private func addLabelsToStackView() {
        parameterNameLabel.translateMask()
        parameterValueLabel.translateMask()
        
        parameterNameLabel.textAlignment = .center
        parameterNameLabel.textColor = UIColor(named: CustomColors.colorLightGray)
        parameterNameLabel.font = UIFont(name: CustomFonts.loraMedium, size: 18)
        
        parameterValueLabel.textAlignment = .center
        parameterValueLabel.textColor = UIColor(named: CustomColors.colorVanilla)
        parameterValueLabel.font = UIFont(name: CustomFonts.loraSemiBold, size: 18)
        
        stackView.addArrangedSubview(parameterNameLabel)
        stackView.addArrangedSubview(parameterValueLabel)
    }
    
}
