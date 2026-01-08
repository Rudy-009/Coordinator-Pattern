//
//  ViewController_LSJ.swift
//  Smashing-Assignment
//
//  Created by 이승준 on 12/26/25.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let buttonGroup = VerticalButtonGroupView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view = buttonGroup
        
        buttonGroup.backButton
            .addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        buttonGroup.nextButton
            .addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        buttonGroup.notificationButton
            .addTarget(self, action: #selector(handleNotification), for: .touchUpInside)
    }
    
    @objc func handleBack() {
        print("Back button tapped")
    }
    
    @objc func handleNext() {
        print("Next button tapped")
    }
    
    @objc func handleNotification() {
        print("Noti button tapped")
    }
    
    func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }

}

#Preview {
    ProfileViewController()
}

