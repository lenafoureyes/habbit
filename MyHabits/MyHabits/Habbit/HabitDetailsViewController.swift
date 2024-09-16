//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Елена Хайрова on 16.09.2024.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    private let habit: Habit
    private let tableView = UITableView()

    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = habit.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))

        setupTableView()
    }

    @objc private func editHabit() {
        let addHabitVC = AddHabitViewController(habit: habit)
            
            // Передаем ссылку на текущий контроллер
            let navigationController = UINavigationController(rootViewController: addHabitVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let date = HabitsStore.shared.dates[indexPath.row]
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        
        if HabitsStore.shared.habit(habit, isTrackedIn: date) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
}
