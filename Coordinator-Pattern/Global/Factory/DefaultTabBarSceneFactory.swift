//
//  DefaultTabBarSceneFactory.swift
//  Coordinator-Pattern
//
//  Created by 이승준 on 1/8/26.
//

import UIKit

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
