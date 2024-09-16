//
//  AddHabitViewController.swift
//  MyHabits
//
//  Created by Елена Хайрова on 08.09.2024.
//
import UIKit

class AddHabitViewController: UIViewController {
    weak var dismissalDelegate: ModalDismissalDelegate?
    let habitNameTextField = UITextField()
    let colorView = UIView()
    let datePicker = UIDatePicker()
    let titleLablel = UILabel()
    let colorLabel = UILabel()
    let dateLabel = UILabel()
    let selectDateLabel = UILabel()
    let descriptionSelectDataLabel = UILabel()
    
    var currentColor = UIColor.systemRed
    
    var habit: Habit?
    
    var habitsViewController: HabitsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = habit != nil ? "Редактировать" : "Создать"
        setupNavigationBarButtons()
        setupUI()
        
        if let habit = habit {
            loadHabitData(habit)
        }
    }
    
    init(habit: Habit? = nil) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupNavigationBarButtons() {
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonTapped))
        cancelButton.tintColor = UIColor(red: 161/255.0, green: 22/255.0, blue: 204/255.0, alpha: 1.0)
        navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonTapped))
        saveButton.tintColor = UIColor(red: 161/255.0, green: 22/255.0, blue: 204/255.0, alpha: 1.0)
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func setupUI() {
        let isEditingHabit = habit != nil
        if isEditingHabit {
            let deleteButton = UIButton(type: .system)
            deleteButton.setTitle("Удалить привычку", for: .normal)
            deleteButton.setTitleColor(.red, for: .normal)
            deleteButton.translatesAutoresizingMaskIntoConstraints = false
            deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
            view.addSubview(deleteButton)
            
            NSLayoutConstraint.activate([
                deleteButton.heightAnchor.constraint(equalToConstant: 50),
                deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
        }
        titleLablel.text = "НАЗВАНИЕ"
        titleLablel.textColor = .black
        titleLablel.font = UIFont(name: "SFProText-Semibold", size: 13)
        titleLablel.translatesAutoresizingMaskIntoConstraints = false
        
        habitNameTextField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        habitNameTextField.textColor = .systemGray
        habitNameTextField.font = UIFont(name: "SFProText-Regular", size: 17)
        habitNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        colorLabel.text = "ЦВЕТ"
        colorLabel.textColor = .black
        colorLabel.font = UIFont(name: "SFProText-Semibold", size: 13)
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        colorView.backgroundColor = currentColor
        colorView.layer.cornerRadius = 15
        colorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colorViewTapped)))
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.text = "ВРЕМЯ"
        dateLabel.textColor = .black
        dateLabel.font = UIFont(name: "SFProText-Semibold", size: 13)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionSelectDataLabel.text = "Каждый день в"
        descriptionSelectDataLabel.textColor = .black
        descriptionSelectDataLabel.font = UIFont(name: "SFProText-Regular", size: 17)
        descriptionSelectDataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        selectDateLabel.text = ""
        selectDateLabel.textColor = UIColor(red: 161/255.0, green: 22/255.0, blue: 204/255.0, alpha: 1.0)
        selectDateLabel.font = UIFont(name: "SFProText-Regular", size: 17)
        selectDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(datePicker)
        view.addSubview(colorView)
        view.addSubview(habitNameTextField)
        view.addSubview(titleLablel)
        view.addSubview(colorLabel)
        view.addSubview(dateLabel)
        view.addSubview(selectDateLabel)
        view.addSubview(descriptionSelectDataLabel)
        
        NSLayoutConstraint.activate([
            
            titleLablel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            titleLablel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLablel.widthAnchor.constraint(equalToConstant: 90),
            titleLablel.heightAnchor.constraint(equalToConstant: 18),
            
            habitNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46),
            habitNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            habitNameTextField.widthAnchor.constraint(equalToConstant: 350),
            habitNameTextField.heightAnchor.constraint(equalToConstant: 22),
            
            colorLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 83),
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorLabel.widthAnchor.constraint(equalToConstant: 50),
            colorLabel.heightAnchor.constraint(equalToConstant: 18),
            
            colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 108),
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorView.widthAnchor.constraint(equalToConstant: 30),
            colorView.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 153),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.widthAnchor.constraint(equalToConstant: 60),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
            
            descriptionSelectDataLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 194),
            descriptionSelectDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionSelectDataLabel.trailingAnchor.constraint(equalTo: selectDateLabel.leadingAnchor, constant: -10),
            descriptionSelectDataLabel.heightAnchor.constraint(equalToConstant: 22),
            
            selectDateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 194),
            selectDateLabel.leadingAnchor.constraint(equalTo: descriptionSelectDataLabel.trailingAnchor, constant: 10),
            selectDateLabel.heightAnchor.constraint(equalToConstant: 22),
            
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 215),
            datePicker.widthAnchor.constraint(equalToConstant: 375),
            datePicker.heightAnchor.constraint(equalToConstant: 216)
        ])
    }
    
    func loadHabitData(_ habit: Habit) {
        habitNameTextField.text = habit.name
        currentColor = habit.color
        colorView.backgroundColor = habit.color
        datePicker.date = habit.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        selectDateLabel.text = dateFormatter.string(from: habit.date)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        guard let habitName = habitNameTextField.text, !habitName.isEmpty else {
            showAlert(title: "Ошибка", message: "Введите название привычки.")
            return
        }
        
        if let habit = habit {
            habit.name = habitName
            habit.color = currentColor
            habit.date = datePicker.date
        } else {
            let newHabit = Habit(name: habitName, date: datePicker.date, color: currentColor)
            HabitsStore.shared.habits.append(newHabit)
        }
        habitsViewController?.collectionView.reloadData()
        dismiss(animated: true, completion: nil)
        self.dismissalDelegate?.dismissAllModals()
    }
    
    @objc func colorViewTapped() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = currentColor
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }
    
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        selectDateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc private func deleteButtonTapped() {
        guard let habit = habit else { return }
        
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы уверены, что хотите удалить эту привычку?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            if let index = HabitsStore.shared.habits.firstIndex(where: { $0 == habit }) {
                HabitsStore.shared.habits.remove(at: index)
                self.habitsViewController?.collectionView.reloadData()
                self.dismissalDelegate?.dismissAllModals()
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension AddHabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        currentColor = color
        colorView.backgroundColor = color
    }
}
