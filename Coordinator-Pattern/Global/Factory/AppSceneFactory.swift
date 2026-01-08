//
//  AppSceneFactory.swift
//  Smashing-Assignment
//
//  Created by 이승준 on 12/29/25.
//

import UIKit

enum RootSceneType {
    case login
    case signup
    case main
}

protocol RootSceneFactory {
    func makeScene(for type: RootSceneType) -> UIViewController
}

protocol TabBarSceneFactory {
    func makeViewController(for tab: TabBarController.Tab) -> UIViewController
}

final class AppSceneFactory: RootSceneFactory {
    func makeScene(for type: RootSceneType) -> UIViewController {
        switch type {
        case .login:
            let loginVC = LoginViewController()
            return UINavigationController(rootViewController: loginVC)
        case .signup:
            let signUpVC = SignUpViewController()
            return UINavigationController(rootViewController: signUpVC)
        case .main:
            let mainVC = TabBarController()
            return UINavigationController(rootViewController: mainVC)
        }
    }
}

final class DefaultTabBarSceneFactory: TabBarSceneFactory {
    func makeViewController(for tab: TabBarController.Tab) -> UIViewController {
        switch tab {
        case .home:
            let view = HomeViewController()
            view.setBackgroundColor(tab.color)
            return view
        case .searchMatch:
            let view = HomeViewController()
            view.setBackgroundColor(tab.color)
            return view
        case .manageMatch:
            let view = HomeViewController()
            view.setBackgroundColor(tab.color)
            return view
        case .profile:
            let view = HomeViewController()
            view.setBackgroundColor(tab.color)
            return view
        }
    }
}

enum NotificationType {
    case pushNotificationVC      // VC 바로 이동
    case pushManageMatchVC       // 경기 관리로 이동
    case updateButtonColorRed    // UI 상태 변경 (버튼 색상)
}

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        // 각 탭의 Coordinator 생성 및 시작
        let homeNC = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNC)
        
        // ... 다른 탭(Rank 등) 설정
        
        tabBarController.viewControllers = [homeNC]
        navigationController.viewControllers = [tabBarController]
        homeCoordinator.start()
        childCoordinators.append(homeCoordinator)
    }
    
    // MARK: - 전역 이동 메서드
    
}

class HomeCoordinator: Coordinator {
    
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
    }
}

class NotificationViewController: UIViewController {
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
