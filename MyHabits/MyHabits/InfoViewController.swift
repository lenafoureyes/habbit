//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Елена Хайрова on 08.09.2024.
//
import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.title = "Информация"
        
        let description = UILabel()
        description.text = "Привычка за 21 день"
        description.font = UIFont(name: "SFProDisplay-Semibold", size: 20)
        description.translatesAutoresizingMaskIntoConstraints = false
        
        let infoTextView = UITextView()
        infoTextView.font = UIFont(name: "SFProText-Regular", size: 17)
        infoTextView.text = """
         Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
         
         1. Провести 1 день без обращения
         к старым привычкам, стараться вести себя так, как будто цель, загаданная
         в перспективу, находится на расстоянии шага.
         
         2. Выдержать 2 дня в прежнем состоянии самоконтроля.
         
         3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче,
         с чем еще предстоит серьезно бороться.
         
         4. Поздравить себя с прохождением первого серьезного порога в 21 день.
         За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и не будет таким трудным.
         
         5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
         
         6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
            
         """
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoTextView)
        view.addSubview(description)
        
        NSLayoutConstraint.activate([
            description.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            description.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            description.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        
            infoTextView.topAnchor.constraint(equalTo: description.bottomAnchor, constant: 10),
            infoTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
