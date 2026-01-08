//
//  SearchMatchViewController.swift
//  Coordinator-Pattern
//
//  Created by 이승준 on 1/6/26.
//

import UIKit
import Combine

import Then
import SnapKit

final class SearchMatchViewController: UIViewController {
    
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
    SearchMatchViewController()
}
