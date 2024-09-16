//
//  CustomTitleView.swift
//  MyHabits
//
//  Created by Елена Хайрова on 15.09.2024.
//
import UIKit

class CustomTitleView: UIView {
    
    // MARK: - Инициализация
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Настройка вью
    
    private func setupView() {
        // Создаем лейбл с заголовком
        let label = UILabel()
        label.text = "Сегодня"
        label.font = UIFont(name: "SfProDisplay-Semibold", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем лейбл во вью
        addSubview(label)
        
        // Устанавливаем констрейнты для CustomTitleView
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 140), // Устанавливаем фиксированную высоту
        ])
        
        // Настройка констрейнтов для лейбла внутри CustomTitleView
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
