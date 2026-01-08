//
//  LoginViewController.swift
//  Smashing-Assignment
//
//  Created by 이승준 on 12/29/25.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let buttonGroup = VerticalButtonGroupView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view = buttonGroup
        
        buttonGroup.nextButton.setTitle("로그인 성공", for: .normal)
        buttonGroup.backButton.setTitle("로그인 실패", for: .normal)
        buttonGroup.notificationButton.setTitle("온보딩으로 이동", for: .normal)
        
        buttonGroup.backButton
            .addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        buttonGroup.nextButton
            .addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        buttonGroup.notificationButton
            .addTarget(self, action: #selector(handleNotification), for: .touchUpInside)
    }
    
    @objc func handleBack() {
        print("Login Successed button tapped")
    }
    
    @objc func handleNext() {
        print("Login Failed button tapped")
    }
    
    @objc func handleNotification() {
        print("Onboard button tapped")
    }
    
    func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }

}
