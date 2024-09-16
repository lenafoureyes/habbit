//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Елена Хайрова on 08.09.2024.
//
import UIKit

class HabitsViewController: UIViewController {
    
    public var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()  // Вызов сначала, чтобы коллекция была настроена до layout
        setupLayout()          // Вызов после настройки collectionView
        setupCustomNavigationBar()
        view.backgroundColor = .white
    }

    // Настраиваем кастомный заголовок и кнопку добавления привычек
    private func setupCustomNavigationBar() {
        // Настраиваем кнопку добавления привычек в правом углу
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }

    @objc func addButtonTapped() {
        let addHabitVC = AddHabitViewController()
        addHabitVC.habitsViewController = self // Передаем ссылку на текущий контроллер
        let navigationController = UINavigationController(rootViewController: addHabitVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }

    // Настройка компоновки экрана
    private func setupLayout() {
        // Создаем кастомный заголовок
        let customTitleView = CustomTitleView()
        customTitleView.translatesAutoresizingMaskIntoConstraints = false
        
        // Создаем стек для размещения заголовка и коллекции
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем в стек кастомное представление заголовка и коллекцию
        stackView.addArrangedSubview(customTitleView)
        stackView.addArrangedSubview(collectionViewContainer())

        view.addSubview(stackView)
        
        // Устанавливаем констрейнты для стека
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Фиксированная высота для кастомного заголовка
            customTitleView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    // Создаем контейнер для UICollectionView
    private func collectionViewContainer() -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(collectionView)
        
        // Устанавливаем констрейнты для коллекции
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }

    // Настройка UICollectionView
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)

        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.identifier, for: indexPath) as! ProgressCollectionViewCell
            cell.configure(with: HabitsStore.shared.todayProgress)
            cell.backgroundColor = .white
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as! HabitCollectionViewCell
            let habit = HabitsStore.shared.habits[indexPath.item]
            cell.configure(with: habit)
            cell.backgroundColor = .white
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 343
        if indexPath.section == 0 {
            return CGSize(width: cellWidth, height: 60)
        } else {
            return CGSize(width: cellWidth, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sideInset = (collectionView.frame.width - 343) / 2
        return UIEdgeInsets(top: 16, left: sideInset, bottom: 16, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

// MARK: - HabitCollectionViewCellDelegate

extension HabitsViewController: HabitCollectionViewCellDelegate {
    func didTapTrackButton(for habit: Habit) {
        if !habit.isAlreadyTakenToday {
            HabitsStore.shared.track(habit)
            collectionView.reloadData() // Обновляем коллекцию после трекинга привычки
        }
    }
}
