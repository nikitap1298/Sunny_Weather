//
//  SetUpSearchView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 24.08.2022.
//

import UIKit

// MARK: - SetUpSearchView
class TextView: UIView {
    
    let mainView = UIView()
    let searchTextField = UISearchTextField()
    let cancelButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    private func setUpUI() {
        self.addSubview(mainView)
        mainView.addSubview(searchTextField)
        mainView.addSubview(cancelButton)
        
        mainView.translateMask()
        searchTextField.translateMask()
        cancelButton.translateMask()
        
        // SearchTextField
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search for a place",
            attributes: [NSAttributedString.Key.foregroundColor: SearchColors.searchTextFieldText ?? UIColor.systemGray,
                         NSAttributedString.Key.font: UIFont(name: CustomFonts.loraMedium, size: 17) ?? UIFont.systemFont(ofSize: 17)
                        ]
        )
        searchTextField.textAlignment = .left
        searchTextField.textColor = SearchColors.searchTextFieldText
        searchTextField.backgroundColor = SearchColors.searchTextField
        searchTextField.addCornerRadius()
        
        // PlaceHolder Image
        let leftVeiwView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        searchTextField.leftView = leftVeiwView
        searchTextField.leftViewMode = .always
        let iconImage = UIImageView(frame: CGRect(x: 10, y:10, width: 22, height: 20))
        iconImage.tintColor = SearchColors.searchTextFieldText
        iconImage.image = SFSymbols.search
        leftVeiwView.addSubview(iconImage)
        
        // Cancel Button
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(SearchColors.searchTextFieldText, for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: CustomFonts.loraMedium, size: 17)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            searchTextField.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            searchTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
            searchTextField.trailingAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 75),
            searchTextField.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
             
            cancelButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            cancelButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 15),
            cancelButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
            cancelButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0)
        ])
        
    }
    
}
