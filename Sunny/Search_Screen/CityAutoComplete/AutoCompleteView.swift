//
//  AutoCompleteView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 02.11.2022.
//

import UIKit

// MARK: - AutoCompleteView
class AutoCompleteView: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    private func setUpUI() {
        self.addSubview(tableView)
        tableView.translateMask()
        
        tableView.addCornerRadius()
        tableView.rowHeight = 50.0
        tableView.backgroundColor = SearchColors.tableView
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - CustomAutoCompleteCell
class CustomAutoCompleteCell: UITableViewCell {
    
    static let identifier = String(describing: CustomAutoCompleteCell.self)
    
    let placeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = SearchColors.tableView
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setUpUI()
    }
    
    override func prepareForReuse() {
        placeLabel.text = nil
    }
    
    func fillPlaceLabel(_ place: String) {
        placeLabel.text = place
    }
    
    private func setUpUI() {
        self.addSubview(placeLabel)
        placeLabel.translateMask()
        
        placeLabel.addCornerRadius()
        placeLabel.textColor = SearchColors.searchTextFieldText
        placeLabel.font = UIFont(name: CustomFonts.loraMedium, size: 16)
        
        NSLayoutConstraint.activate([
            placeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            placeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            placeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            placeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
