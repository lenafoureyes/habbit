//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Елена Хайрова on 14.09.2024.
//
import UIKit

protocol HabitCollectionViewCellDelegate: AnyObject {
    func didTapTrackButton(for habit: Habit)
}

class HabitCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HabitCollectionViewCell"
    
    weak var delegate: HabitCollectionViewCellDelegate?
    private var habit: Habit?
    
    private let maxTrackCount = 5
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trackButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupCell()
        trackButton.addTarget(self, action: #selector(trackButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(nameLabel)
        addSubview(timeLabel)
        addSubview(progressLabel)
        addSubview(trackButton)
        
        NSLayoutConstraint.activate([
            trackButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trackButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            trackButton.widthAnchor.constraint(equalToConstant: 38),
            trackButton.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trackButton.leadingAnchor, constant: -16),
            
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: trackButton.leadingAnchor, constant: -16),
            
            progressLabel.topAnchor.constraint(equalTo: topAnchor, constant: 92),
            progressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            progressLabel.trailingAnchor.constraint(equalTo: trackButton.leadingAnchor, constant: -16)
        ])
    }
    
    private func setupCell() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func configure(with habit: Habit) {
        self.habit = habit
        nameLabel.text = habit.name
        timeLabel.text = habit.dateString
        nameLabel.textColor = habit.color
        
        updateProgress()
    }
    
    @objc private func trackButtonTapped() {
        guard let habit = habit else { return }
        
        let totalTrackCount = habit.trackDates.count
        
        if totalTrackCount < maxTrackCount && !habit.isAlreadyTakenToday {
            delegate?.didTapTrackButton(for: habit)
            
            updateProgress()
        } else {
            print("Максимальное количество выполнений достигнуто или уже отмечено сегодня.")
        }
    }
    
    private func updateProgress() {
        guard let habit = habit else { return }
        
        let totalTrackCount = habit.trackDates.count
        
        if habit.isAlreadyTakenToday {
            trackButton.backgroundColor = habit.color
            trackButton.layer.borderColor = habit.color.cgColor
            trackButton.setTitle("✓", for: .normal)
            trackButton.setTitleColor(.white, for: .normal)
        } else {
            trackButton.backgroundColor = .white
            trackButton.layer.borderColor = habit.color.cgColor
            trackButton.setTitle("", for: .normal)
            trackButton.setTitleColor(.clear, for: .normal)
        }
        
        progressLabel.text = "Счетчик: \(totalTrackCount)"
        
        trackButton.isEnabled = totalTrackCount < maxTrackCount && !habit.isAlreadyTakenToday
    }
}
