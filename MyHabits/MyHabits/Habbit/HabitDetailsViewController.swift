//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Елена Хайрова on 16.09.2024.
//
import UIKit

class HabitDetailsViewController: UIViewController {
    
    weak var dismissalDelegate: ModalDismissalDelegate?
    private let habit: Habit
    private let tableView = UITableView()
    
    // Цвет для кнопок и галочки
    private let buttonColor = UIColor(red: 161/255.0, green: 22/255.0, blue: 204/255.0, alpha: 1.0)

    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        navigationItem.title = habit.name

        // Настраиваем навигационный бар на белый цвет
        setupNavigationBarAppearance()
        
        // Создаем кастомную кнопку "Назад" с изображением и текстом, используя UIButtonConfiguration
        let backButton = UIButton(type: .system)
        
        // Настраиваем конфигурацию для кнопки
        var backConfig = UIButton.Configuration.plain()
        backConfig.title = "Назад"
        backConfig.image = UIImage(systemName: "chevron.backward")
        backConfig.imagePadding = 6  // Отступ между изображением и текстом
        backConfig.imagePlacement = .leading  // Изображение перед текстом
        backConfig.baseForegroundColor = buttonColor  // Цвет текста и изображения
        
        backButton.configuration = backConfig
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // Используем кастомную кнопку в качестве UIBarButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        // Добавляем кнопку "Править"
        let editButton = UIButton(type: .system)
        
        var editConfig = UIButton.Configuration.plain()
        editConfig.title = "Править"
        editConfig.baseForegroundColor = buttonColor  // Цвет текста
        
        editButton.configuration = editConfig
        editButton.addTarget(self, action: #selector(editHabit), for: .touchUpInside)
        
        // Используем кастомную кнопку "Править" в качестве UIBarButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)

        // Настраиваем интерфейс с таблицей и лейблом
        setupInfoLabel()
        setupTableView()
    }

    private func setupNavigationBarAppearance() {
        // Устанавливаем белый фон для навигационного бара
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white // Белый фон навигационного бара
        
        // Убираем тень (либо можно установить её цвет, если нужно)
        appearance.shadowColor = nil
        
        // Устанавливаем стиль для текста заголовка
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,  // Черный цвет текста заголовка
            .font: UIFont(name: "SfPr", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold)  // Использование кастомного шрифта
        ]

        
        // Применяем эту конфигурацию ко всем состояниям навигационного бара
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        // Устанавливаем белый цвет кнопок в навигационном баре
        navigationController?.navigationBar.tintColor = .black  // Цвет кнопок
    }

    private func setupInfoLabel() {
        let infoLabel = UILabel()
        infoLabel.text = "АКТИВНОСТЬ"
        infoLabel.font = UIFont(name: "SfProText-Regular", size: 13)
        infoLabel.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoLabel.heightAnchor.constraint(equalToConstant: 20) // Устанавливаем высоту для лейбла
        ])
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Цвет фона таблицы
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),  // Отступ ниже лейбла
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    @objc private func backButtonTapped() {
        // Вернуться назад или закрыть модальное окно
        dismiss(animated: true, completion: nil)
    }

    @objc private func editHabit() {
        let addHabitVC = AddHabitViewController(habit: habit)
        addHabitVC.dismissalDelegate = self.dismissalDelegate
        let navController = UINavigationController(rootViewController: addHabitVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    // Метод для создания изображения галочки нужного цвета
    private func createCheckmarkImage() -> UIImage? {
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        let image = UIImage(systemName: "checkmark", withConfiguration: config)?
            .withTintColor(buttonColor, renderingMode: .alwaysOriginal)
        return image
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Количество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    // Конфигурация ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let date = HabitsStore.shared.dates[indexPath.row]
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        cell.textLabel?.font = UIFont(name: "SfProText-Regular", size: 17)
        
        // Проверяем, отмечена ли привычка, и используем кастомную галочку
        if HabitsStore.shared.habit(habit, isTrackedIn: date) {
            let checkmarkImage = createCheckmarkImage()
            cell.accessoryView = UIImageView(image: checkmarkImage) // Устанавливаем кастомную галочку
        } else {
            cell.accessoryView = nil // Убираем галочку, если привычка не отмечена
        }
        
        return cell
    }
}
