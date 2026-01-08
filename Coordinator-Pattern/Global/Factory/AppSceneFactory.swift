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
            return LoginViewController()
        case .signup:
            return SignUpViewController()
        case .main:
            return TabBarController()
        }
    }
}

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

final class AppCoordinator: Coordinator {
        
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        // 1. 하위 코디네이터 생성 (NavigationController 전달)
        // 만약 Delegate가 필요하다면 여기서 주입합니다.
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        
        // 2. 자식 배열에 추가하여 메모리 누수 방지 (Strong Reference)
        childCoordinators.append(homeCoordinator)
        
        // 3. 하위 흐름 시작 -> 여기서 HomeViewController가 Push 됩니다.
        homeCoordinator.start()
    }
}

final class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        navigationController.pushViewController(HomeViewController(), animated: true)
    }
    
    func pushManageViewController() {
        let coordinator = ManageMatchCoordinator(
            navigationController: navigationController,
            delegate: self
        )
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}

extension HomeCoordinator: ManageMatchCoordinatorDelegate {
    func didFinish(child: any Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}

protocol ManageMatchCoordinatorDelegate: AnyObject {
    func didFinish(child: Coordinator)
}

final class ManageMatchCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    weak var delegate: ManageMatchCoordinatorDelegate?

    init(navigationController: UINavigationController,
         delegate: ManageMatchCoordinatorDelegate) {
        self.delegate = delegate
        self.childCoordinators = []
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.pushViewController(ManageMatchViewController(), animated: true)
    }
    
    func pushProfileViewController() {
        let coordinator = ProfileCoordinator(
            navigationController: navigationController,
            delegate: self
        )
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    func back() {
        delegate?.didFinish(child: self)
        navigationController.popToRootViewController(animated: true)
    }
}

extension ManageMatchCoordinator: ProfileCoordinatorDelegate {
    func didFinish(child: any Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}

protocol ProfileCoordinatorDelegate: AnyObject {
    func didFinish(child: Coordinator)
}

final class ProfileCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    weak var delegate: ProfileCoordinatorDelegate?

    init(navigationController: UINavigationController,
         delegate: ProfileCoordinatorDelegate) {
        self.delegate = delegate
        self.childCoordinators = []
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.pushViewController(ProfileViewController(), animated: true)
    }
    
    func back() {
        delegate?.didFinish(child: self)
        navigationController.popToRootViewController(animated: true)
    }
}
