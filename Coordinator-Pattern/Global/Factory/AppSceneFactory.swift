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

protocol TabBarSceneFactory {
    func makeViewController(for tab: TabBarController.Tab) -> UIViewController
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
    func start()
}

// AppCoordinator가 외부(ViewModel 등)로부터 호출받을 인터페이스
protocol AppCoordinatorProtocol: Coordinator {
    func showLoginFlow()
    func showMainFlow()
}

protocol AppChildCoordinatorFactory {
    func makeLoginCoordinator(parent: AppCoordinatorProtocol) -> Coordinator
    func makeTabCoordinator(parent: AppCoordinatorProtocol) -> Coordinator
}

final class AppCoordinator: AppCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow?
    private let factory: AppChildCoordinatorFactory
    private let viewSwitcher: RootViewSwitcherProtocol
    
    init(window: UIWindow?,
         factory: AppChildCoordinatorFactory,
         viewSwitcher: RootViewSwitcherProtocol = RootViewSwitcher.shared) {
        self.window = window
        self.factory = factory
        self.viewSwitcher = viewSwitcher
    }
    
    func start() {
        showLoginFlow()
    }
    
    func showLoginFlow() {
        // 1. 기존의 모든 자식 흐름 정리
        childCoordinators.removeAll()
        
        // 2. 팩토리를 통해 로그인 코디네이터 생성 및 시작
        let loginCoordinator = factory.makeLoginCoordinator(parent: self)
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
        
        // 3. ViewSwitcher를 통한 실제 Root 뷰 교체 명령
        // (loginCoordinator로부터 rootViewController를 받아와서 전달)
        // viewSwitcher.setRoot(, animated: true)
    }
    
    func showMainFlow() {
        childCoordinators.removeAll()
        
        let tabCoordinator = factory.makeTabCoordinator(parent: self)
        childCoordinators.append(tabCoordinator)
        tabCoordinator.start()
        
        // viewSwitcher.updateRootView(to: tabCoordinator.rootViewController)
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
