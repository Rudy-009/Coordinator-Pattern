//
//  SceneDelegate.swift
//  Coordinator-Pattern
//
//  Created by 이승준 on 1/6/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    // 1. AppCoordinator를 프로퍼티로 소유하여 메모리에 유지시킵니다.
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // 2. 앱 전체에서 공유할 Root NavigationController를 생성합니다.
        let navigationController = UINavigationController()

        // 3. AppCoordinator를 초기화합니다.
        appCoordinator = AppCoordinator(navigationController: navigationController)

        // 4. AppCoordinator의 start()를 호출하여 첫 화면(Flow)을 결정합니다.
        appCoordinator?.start()

        // 5. UIWindow를 설정하고 화면에 표시합니다.
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController // Coordinator가 관리하는 네비게이션을 루트로 설정
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

