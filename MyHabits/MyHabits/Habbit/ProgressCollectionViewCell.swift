//
//  ProgressCollectionViewController.swift
//  MyHabits
//
//  Created by Елена Хайрова on 14.09.2024.
//
import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProgressCollectionViewCell"
    
    // Прогресс-бар
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
        progressView.trackTintColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        progressView.layer.cornerRadius = 3.5 // Закругляем углы прогресс-бара
        progressView.clipsToBounds = true
        return progressView
    }()
    
    // Заголовок "Прогресс дня"
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.font = UIFont(name: "SfProText-Semibold", size: 13)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Лейбл для отображения процента прогресса
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.font = UIFont(name: "SfProText-Semibold", size: 13)
        label.textColor = .systemGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(progressLabel)
        addSubview(progressView)
        addSubview(percentageLabel) // Добавляем лейбл для процентов
        
        NSLayoutConstraint.activate([
            // Настраиваем заголовок "Прогресс дня"
            progressLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            progressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            // Настраиваем лейбл процентов
            percentageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            percentageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            // Настраиваем прогресс-бар
            progressView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 8),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            progressView.widthAnchor.constraint(equalToConstant: 319) // Ширина прогресс-бара
        ])
    }
    
    private func setupCell() {
        layer.cornerRadius = 10 // Закругляем углы ячейки
        layer.masksToBounds = true // Обрезаем содержимое по границам
    }
    
    // Метод конфигурации ячейки с установкой прогресса и процентов
    func configure(with progress: Float) {
        progressView.setProgress(progress, animated: true)
        
        // Рассчитываем процент и обновляем лейбл
        let percentage = Int(progress * 100)
        percentageLabel.text = "\(percentage)%"
    }
}
