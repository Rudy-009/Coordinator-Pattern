//
//  HomeView.swift
//  NewCombine
//
//  Created by JIN on 12/26/25.
//

import UIKit

import SnapKit
import Then

class HomeView: UIView {
    
    // MARK: - UI
    
    let submitButton = UIButton(type: .system).then {
        $0.setTitle("Next", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(.white.withAlphaComponent(0.6), for: .disabled)
        $0.backgroundColor = .lightGray
        $0.isEnabled = false
        $0.layer.cornerRadius = 8
    }
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupLayout()
    }
    
    // MARK: - SetLayout
    
    private func setupUI() {
        backgroundColor = .systemBackground
        addSubview(submitButton)
    }
    
    private func setupLayout() {
        submitButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
    }
}
