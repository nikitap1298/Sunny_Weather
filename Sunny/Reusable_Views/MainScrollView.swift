//
//  MainScrollView.swift
//  Sunny
//
//  Created by Nikita Pishchugin on 26.08.2022.
//

import UIKit

class MainScrollView: UIView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var contentViewHeightAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpScrollView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpScrollView()
    }
    
    private func setUpScrollView() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translateMask()
        contentView.translateMask()
        
//        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        
        contentViewHeightAnchor = contentView.heightAnchor.constraint(equalToConstant: Constraints.contentViewTodayHeight)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        guard let contentViewHeightAnchor = contentViewHeightAnchor else { return }
        contentViewHeightAnchor.isActive = true
    }
}
