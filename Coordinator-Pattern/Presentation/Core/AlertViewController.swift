//
//  AlertViewController.swift
//  Smashing-Assignment
//
//  Created by 이승준 on 12/29/25.
//

import UIKit

final class AlertViewController: UIViewController {
    
    private let goToManageMatchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("매칭 관리 탭으로 이동", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(goToManageMatchButton)
        
        NSLayoutConstraint.activate([
            goToManageMatchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToManageMatchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            goToManageMatchButton.widthAnchor.constraint(equalToConstant: 200),
            goToManageMatchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        goToManageMatchButton.addTarget(self, action: #selector(jinjaeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func jinjaeButtonTapped() {
        goToJinjae()
    }
    
    func goToJinjae() {
        TabBarController.shared?.switchToTab(.home)
        self.navigationController?.popViewController(animated: true)
    }
}
