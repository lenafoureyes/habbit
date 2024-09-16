//
//  CustomTitleView.swift
//  MyHabits
//
//  Created by Елена Хайрова on 15.09.2024.
//
import UIKit

class CustomTitleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let label = UILabel()
        label.text = "Сегодня"
        label.font = UIFont(name: "SfProDisplay-Semibold", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 140),
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
