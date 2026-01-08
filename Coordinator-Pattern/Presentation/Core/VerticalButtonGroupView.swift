//
//  VerticalButtonGroupView.swift
//  Coordinator-Pattern
//
//  Created by 이승준 on 1/6/26.
//

import UIKit
import SnapKit
import Then

class VerticalButtonGroupView: UIView {
    
    // MARK: - UI Components
    
    // Using 'Then' for declarative initialization
    let backButton = UIButton(type: .system).then {
        $0.setTitle("Back", for: .normal)
        $0.backgroundColor = .black
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
    }
    
    let nextButton = UIButton(type: .system).then {
        $0.setTitle("Next", for: .normal)
        $0.backgroundColor = .black
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
    }
    
    let notificationButton = UIButton(type: .system).then {
        $0.setTitle("Notification", for: .normal)
        $0.backgroundColor = .black
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 12
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupLayout() {
        // Add buttons to stack view
        [backButton, nextButton, notificationButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        addSubview(stackView)
        
        // SnapKit constraints
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview() // Padding from view edges
            make.height.equalTo(150)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        // Setting specific heights for buttons
        [backButton, nextButton, notificationButton].forEach { button in
            button.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        }
    }
}
